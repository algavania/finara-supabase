-- Create savings_goals table
CREATE TABLE savings_goals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  target_amount DECIMAL(15,2) NOT NULL,
  current_amount DECIMAL(15,2) DEFAULT 0,
  deadline DATE,
  icon TEXT,
  color TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create goal_contributions table
CREATE TABLE goal_contributions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  goal_id UUID REFERENCES savings_goals(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  amount DECIMAL(15,2) NOT NULL,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add index
CREATE INDEX idx_savings_goals_user_id ON savings_goals(user_id);
CREATE INDEX idx_goal_contributions_goal_id ON goal_contributions(goal_id);
CREATE INDEX idx_goal_contributions_user_id ON goal_contributions(user_id);

-- Enable RLS
ALTER TABLE savings_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE goal_contributions ENABLE ROW LEVEL SECURITY;

-- Policies for savings_goals
CREATE POLICY "Users can view their own savings goals"
  ON savings_goals FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own savings goals"
  ON savings_goals FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own savings goals"
  ON savings_goals FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own savings goals"
  ON savings_goals FOR DELETE
  USING (auth.uid() = user_id);

-- Policies for goal_contributions
CREATE POLICY "Users can view their own goal contributions"
  ON goal_contributions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own goal contributions"
  ON goal_contributions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own goal contributions"
  ON goal_contributions FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own goal contributions"
  ON goal_contributions FOR DELETE
  USING (auth.uid() = user_id);

-- Create trigger to update current_amount in savings_goals when a contribution is made
CREATE OR REPLACE FUNCTION update_savings_goal_current_amount()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE savings_goals SET current_amount = current_amount + NEW.amount WHERE id = NEW.goal_id;
  ELSIF TG_OP = 'UPDATE' THEN
    UPDATE savings_goals SET current_amount = current_amount - OLD.amount + NEW.amount WHERE id = NEW.goal_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE savings_goals SET current_amount = current_amount - OLD.amount WHERE id = OLD.goal_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_savings_goal_current_amount_trigger
AFTER INSERT OR UPDATE OR DELETE ON goal_contributions
FOR EACH ROW EXECUTE FUNCTION update_savings_goal_current_amount();

-- Drop legacy tables
DROP TABLE IF EXISTS email_transactions CASCADE;
DROP TABLE IF EXISTS gmail_tokens CASCADE;

-- RPC for cashflow summary
CREATE OR REPLACE FUNCTION get_monthly_cashflow(p_user_id UUID, p_year INTEGER)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_cashflow JSONB;
BEGIN
  SELECT coalesce(jsonb_agg(
      jsonb_build_object(
          'month', month_idx,
          'income', coalesce(income, 0),
          'expense', coalesce(expense, 0)
      )
  ), '[]'::jsonb) INTO v_cashflow
  FROM (
      SELECT 
          extract(month from date) as month_idx,
          SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as income,
          SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as expense
      FROM transactions
      WHERE user_id = p_user_id AND extract(year from date) = p_year
      GROUP BY extract(month from date)
      ORDER BY month_idx
  ) as monthly_stats;

  RETURN v_cashflow;
END;
$$;
