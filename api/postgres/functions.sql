CREATE OR REPLACE FUNCTION products_upsert(IN par_product_id   INT, IN par_product_name TEXT,
                                            IN par_description TEXT, IN par_price FLOAT ,
                                            IN par_date_added  TIMESTAMP)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
BEGIN

  IF par_product_id ISNULL
  THEN
    INSERT INTO products (product_name, description, price, date_added)
    VALUES (par_product_name, par_description, par_price, par_date_added);
    loc_response = 'OK';
  ELSE
    UPDATE products
    SET product_name = par_product_name, description = par_description, price = par_price
    WHERE product_id = par_product_id;
    loc_response = 'OK';
  END IF;

  RETURN loc_response;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION products_get(IN par_product_id INT)
  RETURNS SETOF products AS $$
BEGIN
  IF par_product_id ISNULL
  THEN
    RETURN QUERY SELECT *
                 FROM products;
  ELSE
    RETURN QUERY SELECT *
                 FROM products
                 WHERE product_id = par_product_id;
  END IF;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION product_infos_upsert(IN par_info_id   INT, IN par_what TEXT,
                                            IN par_when TEXT, IN par_where TEXT, IN par_how TEXT,
                                            IN par_date_added  TIMESTAMP)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
BEGIN

  IF par_info_id ISNULL
  THEN
    INSERT INTO product_infos (_what, _when, _where, _how, date_added)
    VALUES (par_what, par_when, par_where, par_how);
    loc_response = 'OK';
  ELSE
    UPDATE product_infos
    SET _what = par_what, _when= par_when, _where = par_where, _how = par_how
    WHERE info_id = par_info_id;
    loc_response = 'OK';
  END IF;

  RETURN loc_response;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION product_infos_get(IN par_info_id INT)
  RETURNS SETOF product_infos AS $$
BEGIN
  IF par_info_id ISNULL
  THEN
    RETURN QUERY SELECT *
                 FROM product_infos;
  ELSE
    RETURN QUERY SELECT *
                 FROM product_infos
                 WHERE info_id = par_info_id;
  END IF;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION product_videos_upsert(IN par_video_id   INT, IN par_video_name TEXT,
                                            IN par_date_added  TIMESTAMP)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
BEGIN

  IF par_video_id ISNULL
  THEN
    INSERT INTO product_videos(video_name, date_added)
    VALUES (par_video_name, par_date_added);
    loc_response = 'OK';
  ELSE
    UPDATE product_videos
    SET video_name = par_video_name
    WHERE video_id = par_video_id;
    loc_response = 'OK';
  END IF;

  RETURN loc_response;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION product_videos_get(IN par_video_id INT)
  RETURNS SETOF product_videos AS $$
BEGIN
  IF par_info_id ISNULL
  THEN
    RETURN QUERY SELECT *
                 FROM product_videos;
  ELSE
    RETURN QUERY SELECT *
                 FROM product_videos
                 WHERE video_id = par_video_id;
  END IF;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION notes_upsert(IN par_note_id   INT, IN par_name TEXT,
                                        IN par_description TEXT, IN par_date_added  TIMESTAMP)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
BEGIN

  IF par_note_id ISNULL
  THEN
    INSERT INTO notes(note_name, description, date_added)
    VALUES (par_note_name, par_description, par_date_added);
    loc_response = 'OK';
  ELSE
    UPDATE notes
    SET note_name = par_note_name
    WHERE note_id = par_note_id;
    loc_response = 'OK';
  END IF;

  RETURN loc_response;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION notes_get(IN par_note_id INT)
  RETURNS SETOF notes AS $$
BEGIN
  IF par_info_id ISNULL
  THEN
    RETURN QUERY SELECT *
                 FROM notes;
  ELSE
    RETURN QUERY SELECT *
                 FROM notes
                 WHERE note_id = par_note_id;
  END IF;
END;
$$ LANGUAGE 'plpgsql';
--
--
--
CREATE OR REPLACE FUNCTION notes_delete(IN par_note_id INT)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
BEGIN
  IF par_info_id ISNULL
  THEN
    loc_response = 'ID DOES NOT EXIST';
  ELSE
    DELETE FROM notes
    WHERE note_id = par_note_id;
  END IF;
END;
$$ LANGUAGE 'plpgsql';
