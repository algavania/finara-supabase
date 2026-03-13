-- Add tags column to transactions table
ALTER TABLE transactions 
ADD COLUMN tags text[] DEFAULT '{}'::text[];

-- Create an index for the tags column since users might want to filter by tags
CREATE INDEX idx_transactions_tags ON transactions USING GIN (tags);
