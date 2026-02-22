-- Enable pg_cron extension if not already enabled
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Create function to process recurring transactions
CREATE OR REPLACE FUNCTION process_recurring_transactions()
RETURNS void AS $$
DECLARE
  txn RECORD;
  v_next_date DATE;
  v_interval INTERVAL;
BEGIN
  -- Loop through all active recurring transactions where next_date is today or in the past
  FOR txn IN 
    SELECT * FROM transactions 
    WHERE is_recurring = true 
      AND (recurrence_rule->>'next_date')::DATE <= CURRENT_DATE
  LOOP
    -- Insert the new transaction instance
    INSERT INTO transactions (
      user_id, category_id, amount, type, description, merchant, date, is_recurring, source
    ) VALUES (
      txn.user_id,
      txn.category_id,
      txn.amount,
      txn.type,
      txn.description,
      txn.merchant,
      (txn.recurrence_rule->>'next_date')::DATE,
      false, -- The generated instance is not recurring itself
      'cron'
    );

    -- Calculate the next date based on the frequency
    IF txn.recurrence_rule->>'frequency' = 'daily' THEN
      v_interval := '1 day'::interval;
    ELSIF txn.recurrence_rule->>'frequency' = 'weekly' THEN
      v_interval := '1 week'::interval;
    ELSIF txn.recurrence_rule->>'frequency' = 'monthly' THEN
      v_interval := '1 month'::interval;
    ELSIF txn.recurrence_rule->>'frequency' = 'yearly' THEN
      v_interval := '1 year'::interval;
    ELSE
      -- Fallback if frequency is unknown
      v_interval := '1 month'::interval;
    END IF;

    v_next_date := ((txn.recurrence_rule->>'next_date')::DATE + v_interval)::DATE;

    -- Update the parent recurring transaction with the new next_date
    UPDATE transactions 
    SET recurrence_rule = jsonb_set(
      recurrence_rule, 
      '{next_date}', 
      to_jsonb(to_char(v_next_date, 'YYYY-MM-DD'))
    )
    WHERE id = txn.id;
    
  END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Schedule the cron job to run daily at midnight
SELECT cron.schedule(
  'process-recurring-transactions', -- Job name
  '0 0 * * *',                      -- Cron schedule (every day at midnight)
  'SELECT process_recurring_transactions()' -- Command to execute
);
