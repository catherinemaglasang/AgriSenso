CREATE TABLE Seller (
	seller_id SERIAL PRIMARY KEY,
	first_name Varchar(50),
	middle_name Varchar(50),
	last_name Varchar(50),
	email Varchar(50),
	age INT,
	contact_number Varchar(50),
	address Varchar(100)
);

CREATE TABLE Buyer (
	buyer_id SERIAL PRIMARY KEY,
	first_name Varchar(50),
	middle_name Varchar(50),
	last_name Varchar(50),
	email Varchar(50),
	age INT,
	contact_number Varchar(50),
	address Varchar(100)
);

CREATE TABLE SellerContacts (
	contact_id INT REFERENCES Seller(seller_id),
	buyer_name Varchar(50),
	buyer_contact_number Varchar(50)
);

CREATE TABLE BuyerContacts (
		contact_id INT REFERENCES Buyer(buyer_id),
		seller_name Varchar(50),
		seller_contact_number Varchar(50)
	);