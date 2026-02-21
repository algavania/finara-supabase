-- ============================================
-- Finara: Default Categories Seed Data
-- ============================================

-- Note: user_id is NULL for default categories (shared across all users)

-- Expense categories
INSERT INTO categories (user_id, name, icon, color, is_default, type) VALUES
  (NULL, 'Food & Dining', '🍔', '#FF6B6B', true, 'expense'),
  (NULL, 'Transport', '🚗', '#4ECDC4', true, 'expense'),
  (NULL, 'Shopping', '🛒', '#FFE66D', true, 'expense'),
  (NULL, 'Entertainment', '🎮', '#A78BFA', true, 'expense'),
  (NULL, 'Bills & Utilities', '💡', '#F97316', true, 'expense'),
  (NULL, 'Health', '🏥', '#EC4899', true, 'expense'),
  (NULL, 'Education', '📚', '#3B82F6', true, 'expense'),
  (NULL, 'Housing', '🏠', '#8B5CF6', true, 'expense'),
  (NULL, 'Insurance', '🛡️', '#6366F1', true, 'expense'),
  (NULL, 'Personal Care', '💅', '#F472B6', true, 'expense'),
  (NULL, 'Gifts & Donations', '🎁', '#FB923C', true, 'expense'),
  (NULL, 'Other Expense', '📦', '#94A3B8', true, 'expense');

-- Income categories
INSERT INTO categories (user_id, name, icon, color, is_default, type) VALUES
  (NULL, 'Salary', '💰', '#10B981', true, 'income'),
  (NULL, 'Freelance', '💻', '#06B6D4', true, 'income'),
  (NULL, 'Investment', '📈', '#8B5CF6', true, 'income'),
  (NULL, 'Business', '🏢', '#F59E0B', true, 'income'),
  (NULL, 'Gift Received', '🎀', '#EC4899', true, 'income'),
  (NULL, 'Other Income', '💵', '#6EE7B7', true, 'income');
