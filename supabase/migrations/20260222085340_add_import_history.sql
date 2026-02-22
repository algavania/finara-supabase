-- Create document_imports table
CREATE TABLE document_imports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  file_name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add RLS to document_imports
ALTER TABLE document_imports ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own imports" ON document_imports
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own imports" ON document_imports
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own imports" ON document_imports
  FOR DELETE USING (auth.uid() = user_id);

-- Add import_id to transactions
ALTER TABLE transactions 
  ADD COLUMN import_id UUID REFERENCES document_imports(id) ON DELETE SET NULL;
