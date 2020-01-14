
--Generate Primakey Keys customer
CREATE OR REPLACE TRIGGER customer_seq
    BEFORE INSERT ON customers
    FOR EACH ROW
BEGIN
    :NEW.customerID := seq_customers_table.NEXTVAL;    
END;


-- FLIGHTS PK--

CREATE OR REPLACE TRIGGER flights_seq
    BEFORE INSERT ON flights
    FOR EACH ROW
BEGIN
    :NEW.flightID := seq_flights_table.NEXTVAL;        
END;
/

-- RESERVATIONS PK
CREATE OR REPLACE TRIGGER reservation_seq
    BEFORE INSERT ON reservations
    FOR EACH ROW
BEGIN
    :NEW.reservationID := seq_reservations_table.NEXTVAL;
END;
/
