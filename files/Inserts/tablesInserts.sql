
--Customers

INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Joseph', 'Cardenas', '480-728-9310', '6 Crownhardt Street', 'Mesa', 'Arizona');
INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Pennie', 'Aicken', '212-415-3427', '57 Steensland Park', 'New York City', 'New York');
INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Hale', 'Glasard', '267-275-2805', '83 Clarendon Crossing', 'Philadelphia', 'Pennsylvania');
INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Donica', 'Winter', '585-969-5136', '46 Carey Point', 'Rochester', 'New York');
INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Leshia', 'Fishbourn', '786-929-5816', '85477 Northridge Park', 'Miami', 'Florida');
INSERT INTO customers (firstName, lastName, phone, address, city, state) VALUES ('Gaye', 'Zellick', '361-204-9990', '9 Elka Court', 'Corpus Christi', 'Texas');

--Flights
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('John F. Kennedy  International Airport', 'Orlando International Airport', '05-DEC-2019', 40, 300);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('John F. Kennedy  International Airport', 'Orlando International Airport', '05-DEC-2019', 30, 400);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('John F. Kennedy  International Airport', 'Orlando International Airport', '05-DEC-2019', 10, 200);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'Orlando International Airport', '01-DEC-2019', 50, 700);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'Orlando International Airport', '01-DEC-2019', 40, 800);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'Orlando International Airport', '01-DEC-2019', 25, 650);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'Orlando International Airport', '01-DEC-2019', 60, 700);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('London Heathrow Airport', 'John F. Kennedy International Airport', '04-DEC-2019', 80, 700);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Denver International Airport', 'Orlando International Airport', '15-DEC-2019', 40, 300);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('John F. Kennedy  International Airport', 'Denver International Airport', '05-DEC-2019', 40, 600);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('San Francisco International Airport', 'John F. Kennedy  International Airport', '02-NOV-2019', 80, 650);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'John F. Kennedy  International Airport', '01-DEC-2019', 100, 800);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('John F. Kennedy  International Airport', 'San Francisco International Airport', '05-DEC-2019', 40, 800);
INSERT INTO flights(origin ,destination,flightdate,seats,fare) VALUES('Atlanta International Airport', 'Amsterdam Airport Schiphol', '01-DEC-2019', 100, 800);




--Reservations
INSERT INTO reservations(customerID,flightID,tickets,total)VALUES(1000,2000,2,600);
INSERT INTO reservations(customerID,flightID,tickets,total)VALUES(1001,2001,1,800);
INSERT INTO reservations(customerID,flightID,tickets,total)VALUES(1002,2002,4,1200);
INSERT INTO reservations(customerID,flightID,tickets,total)VALUES(1003,2003,3,700);
INSERT INTO reservations(customerID,flightID,tickets,total)VALUES(1004,2004,2,300);
