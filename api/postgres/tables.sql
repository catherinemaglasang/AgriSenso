CREATE TABLE products (
  product_id   SERIAL NOT NULL PRIMARY KEY,
  product_name TEXT,
  description TEXT,
  price FLOAT ,
  date_added TIMESTAMP
);

CREATE TABLE infos (
  info_id   SERIAL NOT NULL PRIMARY KEY,
  product_id INT,
  _what TEXT,
  _when TEXT,
  _where TEXT ,
  _how TEXT ,
  date_added  TIMESTAMP
)

;CREATE TABLE product_infos (
  product_info_id   SERIAL NOT NULL PRIMARY KEY,
  product_id INT,
  info_id_id INT
);

CREATE TABLE videos (
  video_id   SERIAL NOT NULL PRIMARY KEY,
  product_id INT,
  video_name TEXT,
  date_added TIMESTAMP
);

CREATE TABLE product_videos (
  product_video_id   SERIAL NOT NULL PRIMARY KEY,
  product_id INT,
  video_id TEXT
);

CREATE TABLE notes(
  note_id   SERIAL NOT NULL PRIMARY KEY,
  note_name TEXT,
  description TEXT,
  date_added TIMESTAMP
)


