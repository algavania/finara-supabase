DROP FUNCTION IF EXISTS get_user_financial_profile(UUID);

CREATE OR REPLACE FUNCTION get_user_financial_profile(p_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_profile JSONB;
  v_debts JSONB;
  v_budgets JSONB;
  v_expenses JSONB;
BEGIN
  -- 1. Profile Data
  SELECT jsonb_build_object(
      'monthly_income', monthly_income,
      'savings', savings,
      'risk_tolerance', risk_tolerance
  ) INTO v_profile
  FROM profiles
  WHERE id = p_user_id;

  IF v_profile IS NULL THEN
    RETURN jsonb_build_object('error', 'User profile not found');
  END IF;

  -- 2. Debts Array
  SELECT coalesce(jsonb_agg(
      jsonb_build_object(
          'id', id,
          'name', name,
          'type', type,
          'principal', principal,
          'current_balance', current_balance,
          'interest_rate', interest_rate,
          'minimum_payment', minimum_payment,
          'due_date', due_date,
          'penalty_rate', penalty_rate,
          'stress_level', stress_level
      )
  ), '[]'::jsonb) INTO v_debts
  FROM debts
  WHERE user_id = p_user_id AND status = 'active';

  -- 3. Budgets Array (Total and Category limits)
  SELECT coalesce(jsonb_agg(
      jsonb_build_object(
          'category_id', category_id,
          'amount', amount,
          'period', period
      )
  ), '[]'::jsonb) INTO v_budgets
  FROM budgets
  WHERE user_id = p_user_id;

  -- 4. Average Expenses (use subquery to avoid nesting aggregates)
  SELECT coalesce(jsonb_agg(
      jsonb_build_object(
          'category_id', sub.category_id,
          'total_amount', sub.total_amount
      )
  ), '[]'::jsonb) INTO v_expenses
  FROM (
    SELECT category_id, SUM(amount) AS total_amount
    FROM transactions
    WHERE user_id = p_user_id
      AND type = 'expense'
      AND date >= date_trunc('month', CURRENT_DATE)
    GROUP BY category_id
  ) sub;

  -- Finally build the unified object
  RETURN jsonb_build_object(
      'profile', v_profile,
      'debts', v_debts,
      'budgets', v_budgets,
      'recent_expenses', v_expenses
  );
END;
$$;
