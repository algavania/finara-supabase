-- Function to calculate Emergency Buffer (in months)
-- Assumes total savings divided by average monthly expenses over the last 3 months
CREATE OR REPLACE FUNCTION public.calculate_emergency_buffer()
RETURNS numeric AS $$
DECLARE
    total_savings numeric;
    avg_monthly_expense numeric;
    auth_user_id uuid;
BEGIN
    auth_user_id := auth.uid();
    
    -- Get total current savings (sum of current_amount in savings_goals)
    SELECT COALESCE(SUM(current_amount), 0) INTO total_savings
    FROM public.savings_goals
    WHERE user_id = auth_user_id;
    
    -- Calculate average monthly expense over the last 3 months
    SELECT COALESCE(SUM(amount) / 3, 0) INTO avg_monthly_expense
    FROM public.transactions
    WHERE user_id = auth_user_id 
      AND type = 'expense'
      AND date >= (CURRENT_DATE - INTERVAL '3 months');
      
    IF avg_monthly_expense > 0 THEN
        RETURN ROUND(total_savings / avg_monthly_expense, 1);
    ELSE
        RETURN total_savings; -- If no expenses, buffer is just the total savings amount conceptually (or infinite)
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to calculate Cashflow Volatility
-- Returns a volatility score based on the standard deviation of monthly net income
CREATE OR REPLACE FUNCTION public.calculate_cashflow_volatility()
RETURNS numeric AS $$
DECLARE
    auth_user_id uuid;
    std_dev numeric;
BEGIN
    auth_user_id := auth.uid();
    
    WITH monthly_net AS (
        SELECT 
            DATE_TRUNC('month', date) as mth,
            SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) - 
            SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as net_income
        FROM public.transactions
        WHERE user_id = auth_user_id
          AND date >= (CURRENT_DATE - INTERVAL '6 months')
        GROUP BY DATE_TRUNC('month', date)
    )
    SELECT COALESCE(STDDEV_SAMP(net_income), 0) INTO std_dev
    FROM monthly_net;
    
    -- Return standard deviation as a measure of volatility
    -- In a real app we might normalize this, but this gives a raw value.
    RETURN ROUND(std_dev, 2);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
