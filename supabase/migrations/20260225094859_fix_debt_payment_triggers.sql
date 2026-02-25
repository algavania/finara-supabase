-- Fix: Use correct column names (current_balance/status instead of remaining_amount/is_active)

CREATE OR REPLACE FUNCTION public.handle_debt_payment_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.debts
    SET 
        current_balance = GREATEST(0, current_balance - NEW.amount),
        status = CASE WHEN (current_balance - NEW.amount) > 0 THEN 'active' ELSE 'paid_off' END,
        updated_at = NOW()
    WHERE id = NEW.debt_id AND user_id = NEW.user_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.handle_debt_payment_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.debts
    SET 
        current_balance = current_balance + OLD.amount,
        status = 'active',
        updated_at = NOW()
    WHERE id = OLD.debt_id AND user_id = OLD.user_id;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
