-- ============================================================
-- Debt Overdue Consequences System
-- Adds penalty tracking, overdue detection, and auto-penalty application
-- ============================================================

-- 1. Create debt_penalties table
CREATE TABLE IF NOT EXISTS public.debt_penalties (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  debt_id UUID REFERENCES public.debts(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  penalty_amount DECIMAL(15,2) NOT NULL,
  penalty_rate_applied DECIMAL(5,4) NOT NULL,
  days_overdue INTEGER NOT NULL DEFAULT 0,
  applied_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Add overdue tracking columns to debts table
ALTER TABLE public.debts
  ADD COLUMN IF NOT EXISTS last_penalty_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS total_penalties_accrued DECIMAL(15,2) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS overdue_since DATE;

-- 3. Enable RLS on debt_penalties
ALTER TABLE public.debt_penalties ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own penalties"
  ON public.debt_penalties FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own penalties"
  ON public.debt_penalties FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 4. Index for fast lookups
CREATE INDEX IF NOT EXISTS idx_debt_penalties_debt_id ON public.debt_penalties(debt_id);
CREATE INDEX IF NOT EXISTS idx_debt_penalties_user_id ON public.debt_penalties(user_id);
CREATE INDEX IF NOT EXISTS idx_debts_overdue_since ON public.debts(overdue_since) WHERE overdue_since IS NOT NULL;

-- 5. Function: apply_overdue_penalties
-- Finds overdue debts for a user and applies penalty_rate to current_balance.
-- A debt is overdue if:
--   - status = 'active'
--   - due_date is set
--   - The current day of month has passed due_date
--   - No payment was made this billing cycle (current month)
--   - No penalty has been applied this month yet
--   - penalty_rate > 0
CREATE OR REPLACE FUNCTION public.apply_overdue_penalties(p_user_id UUID)
RETURNS JSON AS $$
DECLARE
  v_debt RECORD;
  v_penalty_amount DECIMAL(15,2);
  v_days_overdue INTEGER;
  v_today DATE := CURRENT_DATE;
  v_current_day INTEGER := EXTRACT(DAY FROM v_today);
  v_current_month INTEGER := EXTRACT(MONTH FROM v_today);
  v_current_year INTEGER := EXTRACT(YEAR FROM v_today);
  v_payment_exists BOOLEAN;
  v_penalty_exists BOOLEAN;
  v_results JSON[];
  v_count INTEGER := 0;
BEGIN
  FOR v_debt IN
    SELECT * FROM public.debts
    WHERE user_id = p_user_id
      AND status = 'active'
      AND due_date IS NOT NULL
      AND penalty_rate > 0
      AND current_balance > 0
      AND v_current_day > due_date -- Past the due date this month
  LOOP
    -- Check if a payment was made this month for this debt
    SELECT EXISTS(
      SELECT 1 FROM public.debt_payments
      WHERE debt_id = v_debt.id
        AND user_id = p_user_id
        AND EXTRACT(MONTH FROM payment_date) = v_current_month
        AND EXTRACT(YEAR FROM payment_date) = v_current_year
    ) INTO v_payment_exists;

    -- Skip if user already paid this month
    IF v_payment_exists THEN
      -- Clear overdue_since if it was set
      UPDATE public.debts
      SET overdue_since = NULL, updated_at = NOW()
      WHERE id = v_debt.id AND overdue_since IS NOT NULL;
      CONTINUE;
    END IF;

    -- Check if penalty was already applied this month
    SELECT EXISTS(
      SELECT 1 FROM public.debt_penalties
      WHERE debt_id = v_debt.id
        AND EXTRACT(MONTH FROM applied_at) = v_current_month
        AND EXTRACT(YEAR FROM applied_at) = v_current_year
    ) INTO v_penalty_exists;

    -- Skip if penalty already applied this month
    IF v_penalty_exists THEN
      CONTINUE;
    END IF;

    -- Calculate days overdue
    v_days_overdue := v_current_day - v_debt.due_date;

    -- Calculate penalty amount
    v_penalty_amount := ROUND(v_debt.current_balance * v_debt.penalty_rate, 2);

    -- Insert penalty record
    INSERT INTO public.debt_penalties (debt_id, user_id, penalty_amount, penalty_rate_applied, days_overdue)
    VALUES (v_debt.id, p_user_id, v_penalty_amount, v_debt.penalty_rate, v_days_overdue);

    -- Update debt: add penalty to balance, track totals
    UPDATE public.debts
    SET
      current_balance = current_balance + v_penalty_amount,
      total_penalties_accrued = COALESCE(total_penalties_accrued, 0) + v_penalty_amount,
      last_penalty_at = NOW(),
      overdue_since = COALESCE(overdue_since, v_today),
      updated_at = NOW()
    WHERE id = v_debt.id;

    v_count := v_count + 1;
    v_results := array_append(v_results, json_build_object(
      'debt_id', v_debt.id,
      'debt_name', v_debt.name,
      'penalty_amount', v_penalty_amount,
      'days_overdue', v_days_overdue,
      'new_balance', v_debt.current_balance + v_penalty_amount
    ));
  END LOOP;

  RETURN json_build_object(
    'penalties_applied', v_count,
    'details', COALESCE(to_json(v_results), '[]'::json)
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. Function: get_overdue_debts
-- Returns active debts that are past due with no payment this month
CREATE OR REPLACE FUNCTION public.get_overdue_debts(p_user_id UUID)
RETURNS TABLE (
  debt_id UUID,
  debt_name TEXT,
  creditor TEXT,
  debt_type TEXT,
  current_balance DECIMAL,
  due_date INTEGER,
  penalty_rate DECIMAL,
  days_overdue INTEGER,
  overdue_since DATE,
  projected_penalty DECIMAL,
  total_penalties_accrued DECIMAL,
  last_penalty_at TIMESTAMPTZ,
  has_penalty_this_month BOOLEAN
) AS $$
DECLARE
  v_today DATE := CURRENT_DATE;
  v_current_day INTEGER := EXTRACT(DAY FROM v_today);
  v_current_month INTEGER := EXTRACT(MONTH FROM v_today);
  v_current_year INTEGER := EXTRACT(YEAR FROM v_today);
BEGIN
  RETURN QUERY
  SELECT
    d.id AS debt_id,
    d.name AS debt_name,
    d.creditor,
    d.type AS debt_type,
    d.current_balance,
    d.due_date,
    d.penalty_rate,
    (v_current_day - d.due_date)::INTEGER AS days_overdue,
    d.overdue_since,
    ROUND(d.current_balance * d.penalty_rate, 2) AS projected_penalty,
    COALESCE(d.total_penalties_accrued, 0::DECIMAL) AS total_penalties_accrued,
    d.last_penalty_at,
    EXISTS(
      SELECT 1 FROM public.debt_penalties dp
      WHERE dp.debt_id = d.id
        AND EXTRACT(MONTH FROM dp.applied_at) = v_current_month
        AND EXTRACT(YEAR FROM dp.applied_at) = v_current_year
    ) AS has_penalty_this_month
  FROM public.debts d
  WHERE d.user_id = p_user_id
    AND d.status = 'active'
    AND d.due_date IS NOT NULL
    AND d.current_balance > 0
    AND v_current_day > d.due_date
    AND NOT EXISTS (
      SELECT 1 FROM public.debt_payments dp2
      WHERE dp2.debt_id = d.id
        AND dp2.user_id = p_user_id
        AND EXTRACT(MONTH FROM dp2.payment_date) = v_current_month
        AND EXTRACT(YEAR FROM dp2.payment_date) = v_current_year
    )
  ORDER BY (v_current_day - d.due_date) DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Update the payment insert trigger to clear overdue_since when payment is made
CREATE OR REPLACE FUNCTION public.handle_debt_payment_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.debts
    SET 
        current_balance = GREATEST(0, current_balance - NEW.amount),
        status = CASE WHEN (current_balance - NEW.amount) > 0 THEN 'active' ELSE 'paid_off' END,
        overdue_since = NULL, -- Clear overdue status on payment
        updated_at = NOW()
    WHERE id = NEW.debt_id AND user_id = NEW.user_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
