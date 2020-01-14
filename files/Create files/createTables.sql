CREATE TABLE customers(
    customerID  NUMBER PRIMARY KEY,
    firstName   VARCHAR2(60),
    lastName    VARCHAR2(60),
    phone       VARCHAR2(12),
    address     VARCHAR2(60),
    city        VARCHAR2(30),
    state       VARCHAR2(30)
);


CREATE TABLE flights(
    flightID          NUMBER PRIMARY KEY,
    origin        	  VARCHAR(60),
    destination       VARCHAR(60),
	flightDate		  DATE,
    seats             NUMBER,
    fare              DECIMAL(6,2)
);
    
CREATE TABLE reservations(
    reservationID      NUMBER PRIMARY KEY,
    customerID         NUMBER REFERENCES customers(customerID),
    flightID           NUMBER REFERENCES flights(flightID),  
    tickets      	   NUMBER,
    total              NUMBER(10)
);
