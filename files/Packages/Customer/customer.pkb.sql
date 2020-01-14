
--                          CUSTOMER BODY
CREATE OR REPLACE PACKAGE BODY customer
IS
	PROCEDURE register(firstName_in IN CUSTOMERS.FIRSTNAME%TYPE,lastName_in CUSTOMERS.LASTNAME%TYPE, phone_in CUSTOMERS.PHONE%TYPE, address_in CUSTOMERS.ADDRESS%TYPE,
    city_in IN CUSTOMERS.CITY%TYPE, state_in IN CUSTOMERS.STATE%TYPE)
	AS
	BEGIN
		INSERT INTO CUSTOMERS(firstName, lastName, phone, address, city, state) VALUES(firstName_in,lastName_in,phone_in, address_in, city_in, state_in);
		DBMS_OUTPUT.PUT_LINE('Thank You for Registering '|| firstName_in||'!' || ' Your ID is:' || seq_customers_table.CURRVAL);
	END register;
	

----------------------------------------------------------------------------

    PROCEDURE search(origin_in FLIGHTS.ORIGIN%TYPE, destination_in FLIGHTS.DESTINATION%TYPE, flightdate_in FLIGHTS.FLIGHTDATE%TYPE)
    AS  
        v_flightid      FLIGHTS.FLIGHTID%TYPE;
        v_origin        FLIGHTS.ORIGIN%TYPE;
        v_destination   FLIGHTS.DESTINATION%TYPE;
        v_date          FLIGHTS.FLIGHTDATE%TYPE;
        v_seats         FLIGHTS.SEATS%TYPE;
        v_fare          FLIGHTS.FARE%TYPE;    
    
        -- Help finding city or airport name by typing part of the name
		l_origin			FLIGHTS.ORIGIN%TYPE := UPPER('%' || origin_in || '%');			
        l_destination		FLIGHTS.DESTINATION%TYPE := UPPER('%' || destination_in || '%');
        					
        CURSOR flight_search_cur
        IS							
            SELECT flightID,origin,destination,flightDate,seats,fare
            FROM flights
            WHERE UPPER(origin) LIKE l_origin AND UPPER(destination) LIKE l_destination AND flightDate = flightdate_in;
            			
			
        
        BEGIN
            OPEN flight_search_cur;
                --Column Headers
                DBMS_OUTPUT.PUT_LINE(RPAD('FlightID',15)||RPAD(' Origin ',10)||RPAD(' Destination',17)|| ' 		'||RPAD('Date',10)||RPAD('Seats Available',24)||'Cost'); 
                LOOP
                FETCH flight_search_cur INTO v_flightid, v_origin, v_destination, v_date, v_seats, v_fare;
                EXIT WHEN flight_search_cur%NOTFOUND;
                
                DBMS_OUTPUT.PUT_LINE(RPAD(v_flightid,13) ||' '||RPAD(v_origin,10)||'  '|| RPAD(v_destination,10)||RPAD(' ',10)||RPAD(v_date,20)||' '||RPAD(v_seats,15)||' '||v_fare);
                END LOOP;
            
            CLOSE flight_search_cur;     
        
        END search;


--------------------------------------------------------------------------
 
    PROCEDURE makeReservation(custID_in IN CUSTOMERS.CUSTOMERID%TYPE, flightID_in IN FLIGHTS.FLIGHTID%TYPE, seats_in IN FLIGHTS.SEATS%TYPE)
	AS
    v_fare          FLIGHTS.FARE%TYPE;
    v_seats         FLIGHTS.SEATS%TYPE;
    v_amountPaid    RESERVATIONS.TOTAL%TYPE;
	v_name			CUSTOMERS.FIRSTNAME%TYPE;
    
    --  This exeptions will be raise in two cases:
    --      1. The flight is full
    --      2. Not enough seats 
    no_seats            EXCEPTION;
    
    
	BEGIN
	--Get customer first name
	SELECT firstName INTO v_name FROM customers
	WHERE customerID = custID_in;
	
    --Get the flight's fare 
    SELECT fare,seats INTO v_fare,v_seats FROM flights 
    WHERE flightID = flightID_in;
    
    -- check the amount of seats raise an exception if not enough seats
    IF seats_in > v_seats OR v_seats = 0 THEN
        RAISE no_seats;       
    END IF;
    
    --Calculate the total to  be pay
    v_amountPaid := v_fare * seats_in;
    
    INSERT INTO reservations(customerID,flightID,tickets,total)
           VALUES(custID_in, flightID_in,seats_in, v_amountPaid);
    
    --Update flight total seats remaining
    UPDATE flights
    SET seats = (seats - seats_in)
    WHERE FLIGHTID = flightID_in;
    
    DBMS_OUTPUT.PUT_LINE(v_name||' Your reservation is Completed. '|| seats_in||' Tickets ' || 'Total: $'||v_amountPaid);
    
        
    EXCEPTION
        WHEN no_seats THEN            
            IF seats_in > v_seats AND v_seats >= 1 THEN
                DBMS_OUTPUT.PUT_LINE('Not Enough Seats only  '|| v_seats||' remaining.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Sorry Flight is Full'); 
            END IF;
	END;
---------------------------------------------------------------------------
    
    PROCEDURE viewReservation(customerID_in CUSTOMERS.CUSTOMERID%TYPE)
    AS              
        CURSOR view_res_cur IS
            SELECT r.reservationID,f.origin,f.destination,f.flightDate,r.tickets
            FROM reservations r JOIN flights f ON f.flightID = r.flightID
            WHERE r.customerID = customerID_in;
        
        BEGIN
        DBMS_OUTPUT.PUT_LINE('ReservationID'||' ' ||' 	Origin '||' ' ||'				Destination '||'		Flight Date'||' '||' Tickets');
        
        FOR view_res_rec IN view_res_cur -- For reservations  in the reservations CURSOR
        LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(view_res_rec.reservationID,15)|| RPAD(view_res_rec.origin,20)||' '|| RPAD(view_res_rec.destination,20)||'	  '||RPAD(view_res_rec.flightDate,15)||view_res_rec.tickets);           
        END LOOP;
        
	END viewReservation;

END customer;
