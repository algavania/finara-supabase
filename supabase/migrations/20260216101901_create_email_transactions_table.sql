-- Email Transactions (staging)
CREATE TABLE email_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  gmail_message_id TEXT UNIQUE NOT NULL,
  sender TEXT,
  amount DECIMAL(15,2),
  merchant TEXT,
  transaction_date DATE,
  raw_subject TEXT,
  parsed_data JSONB,
  status TEXT CHECK (status IN ('pending', 'confirmed', 'rejected')) DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT NOW()
);
