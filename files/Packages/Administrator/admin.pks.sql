--ADMIN SPECIFICATION
CREATE OR REPLACE PACKAGE admin AS
PROCEDURE flightDetails(origin_in IN FLIGHTS.ORIGIN%TYPE);
PROCEDURE changeFare(flightID_in IN FLIGHTS.FLIGHTID%TYPE, new_fare FLIGHTS.FARE%TYPE);
PROCEDURE viewReservations(flightID_in IN FLIGHTS.FLIGHTID%TYPE );
PROCEDURE viewCustomer(customerID_in IN CUSTOMERS.CUSTOMERID%TYPE);
PROCEDURE addFlight(origin_in IN FLIGHTS.ORIGIN%TYPE,destination_in IN FLIGHTS.DESTINATION%TYPE,
date_in IN FLIGHTS.FLIGHTDATE%TYPE,seats_in IN FLIGHTS.SEATS%TYPE, fare_in IN FLIGHTS.FARE%TYPE);
END;





