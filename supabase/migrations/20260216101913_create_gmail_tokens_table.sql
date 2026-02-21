-- Gmail Tokens
CREATE TABLE gmail_tokens (
  user_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  refresh_token TEXT NOT NULL,
  connected_at TIMESTAMPTZ DEFAULT NOW()
);
