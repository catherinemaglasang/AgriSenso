create or replace function addseller(par_first_name Varchar, par_middle_name Varchar, par_last_name Varchar, par_email Varchar, par_age INT, par_contact_number Varchar, par_address Varchar) returns TEXT AS
	$$
	DECLARE
		loc_email Varchar;
		loc_res TEXT;

		BEGIN
			SELECT INTO loc_email par_email From Seller WHERE email = par_email;
				if loc_email isnull THEN

			if par_first_name = '' or par_middle_name = '' or par_last_name = '' or par_email = '' or
			 par_age IS NULL or par_contact_number = '' or par_address = '' THEN
			 loc_res = 'Error';

			 ELSE
			 		INSERT INTO Seller (first_name, middle_name, last_name, email, age, contact_number, address)
			 			VALUES (par_first_name, par_middle_name, par_last_name, par_email, par_age, par_contact_number, par_address);
			 							loc_res = 'OK';

			 		end if;
			 		ELSE
			 			loc_res = 'Error';

			 		end if;

			 		return loc_res;
			END;
$$
			LANGUAGE 'plpgsql';

--select addseller('Marjorie', 'Galabin', 'Buctolan', 'marjbuctolan@gmail.com', '19', '09068933722', 'Pualas, Tubod, LDN');

create or replace function getsellers(OUT INT, OUT Varchar, OUT Varchar, OUT Varchar, OUT Varchar, OUT INT, OUT Varchar, OUT Varchar) RETURNS SETOF RECORD AS

$$
	SELECT seller_id, first_name, middle_name, last_name, email, age, contact_number, address FROM Seller;
$$
	LANGUAGE 'sql';

--selecct * from getsellers();

create or replace function getseller_id(IN par_seller_id INT, OUT Varchar, OUT Varchar, OUT Varchar, OUT Varchar, OUT INT,
																				OUT Varchar, OUT Varchar) RETURNS SETOF RECORD AS

$$
	SELECT first_name, middle_name, last_name, email, age, contact_number, address FROM Seller WHERE seller_id = par_seller_id;
$$
	LANGUAGE 'sql';

create or replace function updateseller(par_seller_id INT, par_first_name Varchar, par_middle_name Varchar, par_last_name Varchar, par_email Varchar, par_age INT,
																				par_contact_number Varchar, par_address Varchar) returns void AS

$$
	UPDATE Seller
	SET
		first_name = par_first_name,
		middle_name = par_middle_name,
		last_name = par_last_name,
		email = par_email,
		age = par_age,
		contact_number = par_contact_number,
		address = par_address

	WHERE seller_id = par_seller_id;

$$
	LANGUAGE 'sql';

create or replace function addbuyer(par_first_name Varchar, par_middle_name Varchar, par_last_name Varchar, par_email Varchar, par_age INT, par_contact_number Varchar, par_address Varchar) returns TEXT AS
	$$
	DECLARE
		loc_email Varchar;
		loc_res TEXT;

		BEGIN
			SELECT INTO loc_email par_email From Buyer WHERE email = par_email;
				if loc_email isnull THEN

			if par_first_name = '' or par_middle_name = '' or par_last_name = '' or par_email = '' or
			 par_age IS NULL or par_contact_number = '' or par_address = '' THEN
			 loc_res = 'Error';

			 ELSE
			 		INSERT INTO Buyer (first_name, middle_name, last_name, email, age, contact_number, address)
			 			VALUES (par_first_name, par_middle_name, par_last_name, par_email, par_age, par_contact_number, par_address);
			 							loc_res = 'OK';

			 		end if;
			 		ELSE
			 			loc_res = 'Error';

			 		end if;
			 		return loc_res;
			END;
$$
			LANGUAGE 'plpgsql';

--select addbuyer('Catherine', 'Basay', 'Maglasang', 'maglasangcatherine12@gmail.com', '19', '09252979173', 'Abuno, Iligan City');


create or replace function getbuyers(OUT INT, OUT Varchar, OUT Varchar, OUT Varchar, OUT Varchar, OUT INT, OUT Varchar, OUT Varchar) RETURNS SETOF RECORD AS

$$
	SELECT buyer_id, first_name, middle_name, last_name, email, age, contact_number, address FROM Buyer;
$$
	LANGUAGE 'sql';

--select * from getbuyers();

create or replace function getbuyer_id(IN par_buyer_id INT, OUT Varchar, OUT Varchar, OUT Varchar, OUT Varchar, OUT INT, OUT Varchar, OUT Varchar) RETURNS SETOF RECORD AS

$$
	SELECT first_name, middle_name, last_name, email, age, contact_number, address FROM Buyer WHERE buyer_id = par_buyer_id;
$$
	LANGUAGE 'sql';

create or replace function updatebuyer(par_buyer_id INT, par_first_name Varchar, par_middle_name Varchar, par_last_name Varchar, par_email Varchar, par_age INT,
																				par_contact_number Varchar, par_address Varchar) returns void AS

$$
	UPDATE Buyer
	SET
		first_name = par_first_name,
		middle_name = par_middle_name,
		last_name = par_last_name,
		email = par_email,
		age = par_age,
		contact_number = par_contact_number,
		address = par_address

	WHERE buyer_id = par_buyer_id;

$$
	LANGUAGE 'sql';

create or replace function sellercontacts(par_buyer_name Varchar, par_buyer_contact_number Varchar) RETURNS text AS

$$
	DECLARE
		loc_buyer_contact_number TEXT;
		loc_res TEXT;
	BEGIN
	SELECT INTO loc_buyer_contact_number FROM SellerContacts WHERE buyer_contact_number = par_buyer_contact_number;
	if loc_buyer_contact_number isnull THEN

		if par_buyer_name = '' or par_buyer_contact_number = '' THEN loc_res = 'Error';

		ELSE
			INSERT INTO SellerContacts(buyer_name, buyer_contact_number)
				VALUES(par_buyer_name, par_buyer_contact_number);
				loc_res = 'OK';
			end if;

		ELSE
			loc_res = 'OK';
		end if;

		return loc_res;
	END;
$$
	LANGUAGE 'plpgsql';
