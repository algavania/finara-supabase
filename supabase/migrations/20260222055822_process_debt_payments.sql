-- Function to update remaining_amount when a payment is inserted
CREATE OR REPLACE FUNCTION public.handle_debt_payment_insert()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.debts
    SET 
        remaining_amount = GREATEST(0, remaining_amount - NEW.amount),
        is_active = (remaining_amount - NEW.amount) > 0,
        updated_at = NOW()
    WHERE id = NEW.debt_id AND user_id = NEW.user_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for INSERT
DROP TRIGGER IF EXISTS on_debt_payment_created ON public.debt_payments;
CREATE TRIGGER on_debt_payment_created
    AFTER INSERT ON public.debt_payments
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_debt_payment_insert();

-- Function to revert remaining_amount when a payment is deleted
CREATE OR REPLACE FUNCTION public.handle_debt_payment_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.debts
    SET 
        remaining_amount = remaining_amount + OLD.amount,
        is_active = true, -- Reactivate since the balance went up
        updated_at = NOW()
    WHERE id = OLD.debt_id AND user_id = OLD.user_id;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for DELETE
DROP TRIGGER IF EXISTS on_debt_payment_deleted ON public.debt_payments;
CREATE TRIGGER on_debt_payment_deleted
    AFTER DELETE ON public.debt_payments
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_debt_payment_delete();
