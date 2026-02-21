-- ============================================
-- Indexes
-- ============================================

CREATE INDEX idx_transactions_user_date ON transactions (user_id, date DESC);
CREATE INDEX idx_transactions_user_type ON transactions (user_id, type);
CREATE INDEX idx_debts_user_status ON debts (user_id, status);
CREATE INDEX idx_debt_payments_debt ON debt_payments (debt_id, payment_date DESC);
CREATE INDEX idx_budgets_user ON budgets (user_id);
CREATE INDEX idx_email_transactions_user_status ON email_transactions (user_id, status);
