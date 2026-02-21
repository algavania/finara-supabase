-- Optimization Results (cached)
CREATE TABLE optimization_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  strategy TEXT NOT NULL,
  result JSONB NOT NULL,
  computed_at TIMESTAMPTZ DEFAULT NOW()
);
