-- ============================================
-- Row Level Security
-- ============================================

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE debts ENABLE ROW LEVEL SECURITY;
ALTER TABLE debt_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE optimization_results ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE gmail_tokens ENABLE ROW LEVEL SECURITY;

-- Profiles
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- Categories
CREATE POLICY "Users can manage own categories"
  ON categories FOR ALL USING (auth.uid() = user_id OR is_default = true);

-- Transactions
CREATE POLICY "Users can manage own transactions"
  ON transactions FOR ALL USING (auth.uid() = user_id);

-- Budgets
CREATE POLICY "Users can manage own budgets"
  ON budgets FOR ALL USING (auth.uid() = user_id);

-- Debts
CREATE POLICY "Users can manage own debts"
  ON debts FOR ALL USING (auth.uid() = user_id);

-- Debt Payments
CREATE POLICY "Users can manage own debt payments"
  ON debt_payments FOR ALL USING (auth.uid() = user_id);

-- Optimization Results
CREATE POLICY "Users can manage own optimization results"
  ON optimization_results FOR ALL USING (auth.uid() = user_id);

-- Email Transactions
CREATE POLICY "Users can manage own email transactions"
  ON email_transactions FOR ALL USING (auth.uid() = user_id);

-- Gmail Tokens
CREATE POLICY "Users can manage own gmail tokens"
  ON gmail_tokens FOR ALL USING (auth.uid() = user_id);
