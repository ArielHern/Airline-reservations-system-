CREATE OR REPLACE PACKAGE BODY admin
IS	   
    PROCEDURE flightDetails(origin_in IN FLIGHTS.ORIGIN%TYPE )
    AS
        v_flightID      FLIGHTS.FLIGHTID%TYPE;
        v_origin        FLIGHTS.ORIGIN%TYPE;
        v_destination   FLIGHTS.DESTINATION%TYPE;
        v_flightdate    FLIGHTS.FLIGHTDATE%TYPE;
        v_seats         FLIGHTS.SEATS%TYPE;
        v_fare          FLIGHTS.FARE%TYPE;
        
		-- If no flight is return display message
        no_records      EXCEPTION; 
        
        CURSOR flight_details_cur IS
            SELECT flightID, origin, destination,flightDate, seats, fare
            FROM flights
            WHERE origin LIKE '%' || origin_in || '%';
                     
        BEGIN            
            OPEN flight_details_cur;            
			-- Headers 
            DBMS_OUTPUT.PUT_LINE('FlightID                   Source                         Destination     Date      Available Seats  Fare');                   
            LOOP
                FETCH flight_details_cur INTO v_flightID, v_origin, v_destination, v_flightdate, v_seats, v_fare;
                IF flight_details_cur%ROWCOUNT = 0 THEN
                    RAISE no_records;
                 END IF;
                -- Stop when all records returned.  
                EXIT WHEN flight_details_cur%NOTFOUND;
                
                DBMS_OUTPUT.PUT_LINE(RPAD(v_flightID,20)|| RPAD(v_origin,30)||'        '||RPAD(v_destination,10)||'    '||RPAD(v_flightDate,10) ||'     '||RPAD(v_seats,10) ||'    '||RPAD(v_fare,10));
                                     
            END LOOP;                
			CLOSE flight_details_cur;
            EXCEPTION
                WHEN no_records THEN 
                    --Display message if no flight is found
                    DBMS_OUTPUT.PUT_LINE('SORRY NO FLIGHT FOUND.');            
            
	END flightDetails;
---------------------------------------------------------------------------------------------

	PROCEDURE changeFare(flightID_in IN FLIGHTS.FLIGHTID%TYPE, new_fare FLIGHTS.FARE%TYPE)
        AS
		v_oldFare FLIGHTS.FARE%TYPE;
		BEGIN
            --Implicit Cursor. Save current flight fare into v_oldFare
			SELECT fare INTO v_oldFare FROM flights
			WHERE FLIGHTID = flightID_in;
			
            
			IF new_fare != v_oldFare THEN
				UPDATE flights
				SET FARE = new_fare
				WHERE flightID = flightID_in;
				DBMS_OUTPUT.PUT_LINE('Flight '|| flightID_in||' fare is now: '||new_fare);
			ELSE
				 DBMS_OUTPUT.PUT_LINE('No Changes Were Made.');
			END IF;
	END changeFare;
	
	---------------------------------------------------------------------------------------------
	
    		
		PROCEDURE viewReservations(flightID_in IN FLIGHTS.FLIGHTID%TYPE )
    AS
        v_reservationid RESERVATIONS.RESERVATIONID%TYPE;
        v_firstName     CUSTOMERS.FIRSTNAME%TYPE;
        v_lastName      CUSTOMERS.LASTNAME%TYPE;
        
        no_records      EXCEPTION; -- If no Reservation is return display message
        CURSOR reservations_details_cur IS
            SELECT r.reservationid, c.firstname,c.lastname FROM reservations r, customers c
            WHERE c.CUSTOMERID = r.customerid AND  FLIGHTID = flightID_in;
                     
        BEGIN            
            OPEN reservations_details_cur; 
             --Headers
            DBMS_OUTPUT.PUT_LINE('Reservation ID       Full Name');  
            LOOP
                FETCH reservations_details_cur INTO v_reservationid, v_firstName, v_lastName;
                IF reservations_details_cur%ROWCOUNT = 0 THEN
                    RAISE no_records;
                END IF;               
                EXIT WHEN reservations_details_cur%NOTFOUND;                
                DBMS_OUTPUT.PUT_LINE(RPAD(v_reservationid,20)||v_firstName||','||v_firstName);
                    
            END LOOP;
			CLOSE reservations_details_cur;
            
            EXCEPTION
                WHEN no_records THEN 
                    --Display message if no reservation is found
                    DBMS_OUTPUT.PUT_LINE('SORRY NO RESERVATION FOUND.');                     
            
	END viewReservations;	
	
	---------------------------------------------------------------------------------------------
	
	PROCEDURE viewCustomer(customerID_in IN CUSTOMERS.CUSTOMERID%TYPE)
	AS
    v_customerID    CUSTOMERS.CUSTOMERID%TYPE;
    v_firstName     CUSTOMERS.FIRSTNAME%TYPE;
    v_lastName      CUSTOMERS.LASTNAME%TYPE;   
    v_phone         CUSTOMERS.PHONE%TYPE;
    v_address       CUSTOMERS.ADDRESS%TYPE;
    v_city          CUSTOMERS.CITY%TYPE;
    v_state         CUSTOMERS.ADDRESS%TYPE;   
    
    BEGIN        
        SELECT customerID, firstname,lastname,phone,address,city,state INTO v_customerID, v_firstName,v_lastName,v_phone,v_address,v_city,v_state
        FROM customers 
        WHERE CUSTOMERID = customerID_in;
           
        DBMS_OUTPUT.PUT_LINE('CustomerID' ||'  '||'First Name'||'     '||'Last Name'||'        '||'Phone'||'        '||'Address'||'         '||'City'||'        '||'State');
        DBMS_OUTPUT.PUT_LINE(rpad(v_customerID,12)||RPAD(v_firstName,15)||RPAD(v_lastName,10)||LPAD(v_phone,15)||RPAD(v_address,22)||RPAD(v_city,10)||RPAD(v_state,20));        
	END viewCustomer;
    
	---------------------------------------------------------------------------------------------
	
	PROCEDURE addFlight(origin_in IN FLIGHTS.ORIGIN%TYPE,destination_in IN FLIGHTS.DESTINATION%TYPE,
	date_in IN FLIGHTS.FLIGHTDATE%TYPE,seats_in IN FLIGHTS.SEATS%TYPE, fare_in IN FLIGHTS.FARE%TYPE)
	AS
	BEGIN
		INSERT INTO flights(origin,destination,flightdate,seats,fare)
        VALUES(origin_in, destination_in,date_in,seats_in, fare_in);
		DBMS_OUTPUT.PUT_LINE('New Flight added!');
	END addFlight;
	
	-------------------------------------------------------------------------------
	
END admin;