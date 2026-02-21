-- Debts
CREATE TABLE debts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  creditor TEXT,
  type TEXT CHECK (type IN ('credit_card', 'personal_loan', 'bnpl', 'mortgage', 'student_loan', 'other')) NOT NULL,
  principal DECIMAL(15,2) NOT NULL,
  current_balance DECIMAL(15,2) NOT NULL,
  interest_rate DECIMAL(5,4) NOT NULL,
  minimum_payment DECIMAL(15,2) NOT NULL,
  due_date INTEGER CHECK (due_date BETWEEN 1 AND 31),
  penalty_rate DECIMAL(5,4) DEFAULT 0,
  stress_level INTEGER CHECK (stress_level BETWEEN 1 AND 10) DEFAULT 5,
  status TEXT CHECK (status IN ('active', 'paid_off', 'defaulted')) DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
