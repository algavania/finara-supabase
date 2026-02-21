ALTER TABLE profiles 
ADD COLUMN risk_tolerance TEXT 
  CHECK (risk_tolerance IN ('low', 'medium', 'high')) 
  DEFAULT 'medium';
