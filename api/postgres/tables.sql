CREATE TABLE products (
  product_id   SERIAL NOT NULL PRIMARY KEY,
  product_name TEXT,
  description TEXT,
  price FLOAT ,
  date_added TIMESTAMP
);

CREATE TABLE product_infos (
  info_id   SERIAL NOT NULL PRIMARY KEY,
  _what TEXT,
  _when TEXT,
  _where TEXT ,
  _how TEXT ,
  date_added  TIMESTAMP
);

CREATE TABLE product_videos (
  video_id   SERIAL NOT NULL PRIMARY KEY,
  video_name TEXT,
  date_added TIMESTAMP
);

CREATE TABLE notes(
  note_id   SERIAL NOT NULL PRIMARY KEY,
  note_name TEXT,
  description TEXT,
  date_added TIMESTAMP
)


