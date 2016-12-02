CREATE TABLE products (
  product_id   SERIAL NOT NULL PRIMARY KEY,
  product_name TEXT,
  description TEXT,
  price FLOAT ,
  date_added TIMESTAMP
);

CREATE TABLE infos (
  info_id   SERIAL NOT NULL PRIMARY KEY,
  _what TEXT,
  _when TEXT,
  _where TEXT ,
  _how TEXT ,
  date_added  TIMESTAMP
);

CREATE TABLE product_infos (
  product_info_id SERIAL NOT NULL PRIMARY KEY,
  info_id INT,
  product_id INT,
  date_added TIMESTAMP
);

CREATE TABLE videos (
  video_id   SERIAL NOT NULL PRIMARY KEY,
  video_name TEXT,
  date_added TIMESTAMP
);

CREATE TABLE product_videos (
  product_video_id SERIAL NOT NULL PRIMARY KEY,
  video_id INT,
  product_id INT,
  date_added TIMESTAMP
);

CREATE TABLE notes(
  note_id   SERIAL NOT NULL PRIMARY KEY,
  note_name TEXT,
  description TEXT,
  date_added TIMESTAMP
)


CREATE TABLE Seller (
  seller_id SERIAL NOT NULL PRIMARY KEY,
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

CREATE TABLE contacts (
  contact_id SERIAL PRIMARY KEY,
  c_number Varchar(50),
  name Varchar(50),
  l_name Varchar(50)
);

CREATE TABLE SellerContacts (
  c_id INT REFERENCES contacts(contact_id),
  buyer_name Varchar(50),
  buyer_contact_number Varchar(50)
);

CREATE TABLE BuyerContacts (
    contact_id INT REFERENCES Buyer(buyer_id),
    seller_name Varchar(50),
    seller_contact_number Varchar(50)
  );

