  CREATE OR REPLACE FUNCTION products_upsert(IN par_product_id   INT, IN par_product_name TEXT,
                                            IN par_description TEXT, IN par_price FLOAT ,
                                            IN par_date_added  TIMESTAMP)
  RETURNS TEXT AS $$
DECLARE
  loc_response TEXT;
  loc_out      TEXT;
BEGIN

  IF par_product_id ISNULL
  THEN
    INSERT INTO products (product_name, description, price, date_added)
    VALUES (par_product_name, par_description, par_price, par_date_added)
    RETURNING product_id
      INTO loc_response;
  ELSE
    SELECT INTO loc_out product_id
    FROM products
    WHERE product_id = par_product_id;

    IF loc_out ISNULL
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_out      TEXT;
  BEGIN

    IF par_product_id ISNULL
    THEN
      INSERT INTO products (product_name, description, price, date_added)
      VALUES (par_product_name, par_description, par_price, par_date_added)
      RETURNING product_id
        INTO loc_response;
    ELSE
      SELECT INTO loc_out product_id
      FROM products
      WHERE product_id = par_product_id;

      IF loc_out ISNULL
      THEN
        loc_response = 'error';
      ELSE
        UPDATE products
        SET product_name = par_product_name, description = par_description, price = par_price
        WHERE product_id = par_product_id;
        loc_response = par_product_id;

      END IF;

    END IF;

    RETURN loc_response;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  -- CREATE OR REPLACE FUNCTION products_get(IN par_product_id INT)
  --   RETURNS SETOF products AS $$
  -- BEGIN
  --   IF par_product_id ISNULL
  --   THEN
  --     RETURN QUERY SELECT *
  --                  FROM products;
  --   ELSE
  --     RETURN QUERY SELECT *
  --                  FROM products
  --                  WHERE product_id = par_product_id;
  --   END IF;
  -- END;
  -- $$ LANGUAGE 'plpgsql';


  create or replace function getproducts(In par_product_id INT) RETURNS SETOF products AS

  $$
    BEGIN
    IF par_product_id ISNULL
    THEN
      RETURN QUERY SELECT * FROM products;
    ELSE
      RETURN QUERY SELECT * FROM products WHERE product_id = par_product_id;

    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION infos_upsert(IN par_info_id INT, IN par_what TEXT,
                                              IN par_when TEXT, IN par_where TEXT, IN par_how TEXT,
                                              IN par_date_added  TIMESTAMP)
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_out TEXT;
  BEGIN

    IF par_info_id ISNULL
    THEN
      INSERT INTO infos (_what, _when, _where, _how, date_added)
      VALUES (par_what, par_when, par_where, par_how, par_date_added)
      RETURNING info_id
        INTO loc_response;
    ELSE

      SELECT INTO loc_out info_id
      FROM infos
      WHERE info_id = par_info_id;

      IF loc_out ISNULL
      THEN
        loc_response = 'error';
      ELSE

        UPDATE infos
        SET _what = par_what, _when= par_when, _where = par_where, _how = par_how, date_added = par_date_added
        WHERE info_id = par_info_id;
        loc_response = par_info_id;

      END IF;

    END IF;
    RETURN loc_response;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION infos_get(IN par_info_id INT)
    RETURNS SETOF infos AS $$
  BEGIN
    IF par_info_id ISNULL
    THEN
      RETURN QUERY SELECT *
                   FROM infos;
    ELSE
      RETURN QUERY SELECT *
                   FROM infos
                   WHERE info_id = par_info_id;
    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION product_infos_upsert(IN par_info_id INT, IN par_product_id INT, par_date_added TIMESTAMP )
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_id       INT;
  BEGIN

    SELECT INTO loc_id info_id
    FROM product_infos
    WHERE info_id = par_info_id AND product_id = par_product_id;

    IF par_info_id ISNULL
    THEN
      INSERT INTO product_infos (info_id, product_id, date_added)
      VALUES (par_info_id, par_product_id, par_date_added);
      loc_response = 'OK';
    ELSE
      UPDATE product_infos
      SET date_added = par_date_added
      WHERE info_id = par_info_id AND product_id = par_product_id;
      loc_response = 'OK';
    END IF;

    RETURN loc_response;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION product_infos_get(IN par_info_id INT, IN par_product_id INT)
    RETURNS SETOF product_infos AS $$
  BEGIN
    IF par_info_id ISNULL
    THEN
      RETURN QUERY SELECT *
                   FROM product_infos
                   WHERE product_id = par_product_id;
    ELSE
      RETURN QUERY SELECT *
                   FROM product_infos
                   WHERE info_id = par_info_id AND product_id = par_product_id;
    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION videos_upsert(IN par_video_id INT, IN par_video_name TEXT,
                                              IN par_date_added  TIMESTAMP)
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_out TEXT;
  BEGIN

    IF par_video_id ISNULL
    THEN
      INSERT INTO videos (video_name, date_added)
      VALUES (par_video_name, par_date_added)
      RETURNING video_id
        INTO loc_response;
    ELSE

      SELECT INTO loc_out video_id
      FROM videos
      WHERE video_id = par_video_id;

      IF loc_out ISNULL
      THEN
        loc_response = 'error';
      ELSE

        UPDATE videos
        SET video_name = par_video_name, date_added = par_date_added
        WHERE video_id = par_video_id;
        loc_response = par_video_id;

      END IF;

    END IF;
    RETURN loc_response;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION videos_get(IN par_video_id INT)
    RETURNS SETOF videos AS $$
  BEGIN
    IF par_video_id ISNULL
    THEN
      RETURN QUERY SELECT *
                   FROM videos;
    ELSE
      RETURN QUERY SELECT *
                   FROM videos
                   WHERE video_id = par_video_id;
    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION product_videos_upsert(IN par_video_id INT, IN par_product_id INT, IN par_date_added TIMESTAMP )
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_id       INT;
  BEGIN

    SELECT INTO loc_id video_id
    FROM product_videos
    WHERE video_id = par_video_id AND product_id = par_product_id;

    IF par_video_id ISNULL
    THEN
      INSERT INTO product_videos (video_id, product_id, date_added)
      VALUES (par_video_id, par_product_id, par_date_added);
      loc_response = 'OK';
    ELSE
      UPDATE product_videos
      SET date_added = par_date_added
      WHERE video_id = par_video_id AND product_id = par_product_id;
      loc_response = 'OK';
    END IF;

    RETURN loc_response;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION product_videos_get(IN par_video_id INT, IN par_product_id INT)
    RETURNS SETOF product_videos AS $$
  BEGIN
    IF par_video_id ISNULL
    THEN
      RETURN QUERY SELECT *
                   FROM product_videos
                   WHERE product_id = par_product_id;
    ELSE
      RETURN QUERY SELECT *
                   FROM product_videos
                   WHERE video_id = par_video_id AND product_id = par_product_id;
    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
  --
  --
  --
  CREATE OR REPLACE FUNCTION notes_upsert(IN par_note_id   INT, IN par_note_name TEXT,
                                          IN par_description TEXT, IN par_date_added  TIMESTAMP)
    RETURNS TEXT AS $$
  DECLARE
    loc_response TEXT;
    loc_out TEXT;
  BEGIN

    IF par_note_id ISNULL
    THEN
      INSERT INTO notes(note_name, description, date_added)
      VALUES (par_note_name, par_description, par_date_added)
      RETURNING note_id
        INTO loc_response;
    ELSE

      SELECT INTO loc_out note_id
      FROM notes
      WHERE note_id = par_note_id;

      IF loc_out ISNULL
      THEN
        loc_response = 'error';
      ELSE

        UPDATE notes
        SET note_name = par_note_name
        WHERE note_id = par_note_id;
        loc_response = par_note_id;

      END IF;

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
    IF par_note_id ISNULL
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
    IF par_note_id ISNULL
    THEN
      loc_response = 'ID DOES NOT EXIST';
    ELSE
      DELETE FROM notes
      WHERE note_id = par_note_id;
      loc_response = 'OK';
    END IF;
  END;
  $$ LANGUAGE 'plpgsql';


  --SELECT infos_upsert(1, 'what', 'when', 'where', 'how', 'today');
  --SELECT videos_upsert(NULL, 'video.mp4', 'today');
  --SELECT notes_upsert(NULL, 'note', 'note description', 'today');
  --SELECT products_upsert(NULL, 'product', 'product description', '20.50', 'today');
  --SELECT product_infos_upsert('1', '1', 'today');
  --SELECT product_videos_upsert('1', '1', 'today');

  --
  create or replace function upsert_seller(IN par_seller_id INT, IN par_first_name Varchar, IN par_middle_name Varchar, IN par_last_name Varchar, IN par_email Varchar,
                   In par_password Varchar, In par_age INT, IN par_contact_number Varchar, IN par_address Varchar)
    returns TEXT AS
    $$

    DECLARE
      loc_response TEXT;
      loc_out TEXT;

      BEGIN
        IF par_seller_id ISNULL
        THEN
          INSERT INTO Seller (first_name, middle_name, last_name, email, password, age, contact_number, address)
          VALUES (par_first_name, par_middle_name, par_last_name, par_email, par_password, par_age, par_contact_number, par_address)
          RETURNING seller_id
            INTO loc_response;
        ELSE
          SELECT INTO loc_out seller_id
          FROM Seller
          WHERE seller_id = par_seller_id;

          IF loc_out ISNULL
          THEN
            loc_response = 'error';
          ELSE
            UPDATE Seller
            SET first_name = par_first_name, middle_name = par_middle_name, last_name = par_last_name,
                              email = par_email, password = par_password, age = par_age, contact_number = par_contact_number, address = par_address
            WHERE seller_id = par_seller_id;

          END IF;
      END IF;

      RETURN loc_response;
    END;
    $$ LANGUAGE 'plpgsql';

  --select upsert_seller(NONE, 'Marjorie', 'Galabin', 'Buctolan', 'marjbuctolan@gmail.com', 'asdasd', 19', '09061233822', 'Pualas, Tubod, LDN');


  create or replace function getsellers(In par_seller_id INT) RETURNS SETOF Seller AS

  $$
    BEGIN
    IF par_seller_id ISNULL
    THEN
      RETURN QUERY SELECT * FROM Seller;
    ELSE
      RETURN QUERY SELECT * FROM Seller WHERE seller_id = par_seller_id;

    END IF;
  END;
  $$ LANGUAGE 'plpgsql';

  create or replace function upsert_buyer(IN par_buyer_id INT, IN par_first_name Varchar, IN par_middle_name Varchar, IN par_last_name Varchar, IN par_email Varchar,
                    In par_password Varchar, In par_age INT, IN par_contact_number Varchar, IN par_address Varchar)
    returns TEXT AS
    $$

    DECLARE
      loc_response TEXT;
      loc_out TEXT;

      BEGIN
        IF par_buyer_id ISNULL
        THEN
          INSERT INTO Buyer (first_name, middle_name, last_name, email, password, age, contact_number, address)
          VALUES (par_first_name, par_middle_name, par_last_name, par_email, par_password, par_age, par_contact_number, par_address)
          RETURNING buyer_id
            INTO loc_response;
        ELSE
          SELECT INTO loc_out buyer_id
          FROM Buyer
          WHERE buyer_id = par_buyer_id;

          IF loc_out ISNULL
          THEN
            loc_response = 'error';
          ELSE
            UPDATE Buyer
            SET first_name = par_first_name, middle_name = par_middle_name, last_name = par_last_name,
                              email = par_email, password = par_password, age = par_age, contact_number = par_contact_number, address = par_address
            WHERE buyer_id = par_buyer_id;

          END IF;
      END IF;

      RETURN loc_response;
    END;
    $$ LANGUAGE 'plpgsql';

  --select upsert_buyer(NONE, 'Catherine', 'Basay', 'Maglasang', 'maglasangcatherine12@gmail.com', 'asdasd', 19', '09252979173', 'Abuno, Iligan City');

  create or replace function getbuyers(In par_buyer_id INT) RETURNS SETOF Buyer AS

  $$
    BEGIN
    IF par_buyer_id ISNULL
    THEN
      RETURN QUERY SELECT * FROM Buyer;
    ELSE
      RETURN QUERY SELECT * FROM Buyer WHERE buyer_id = par_buyer_id;

    END IF;
  END;
  $$ LANGUAGE 'plpgsql';

  create or replace function upsert_contact(IN par_contact_id INT, IN par_c_number Varchar, IN par_name Varchar, IN par_l_name Varchar)
    returns TEXT AS
    $$

    DECLARE
      loc_response TEXT;
      loc_out TEXT;

      BEGIN
        IF par_contact_id ISNULL
        THEN
          INSERT INTO contacts (c_number, name, l_name)
          VALUES (par_c_number, par_name, par_l_name)
          RETURNING contact_id
            INTO loc_response;
        ELSE
          SELECT INTO loc_out contact_id
          FROM contacts
          WHERE contact_id = par_contact_id;

          IF loc_out ISNULL
          THEN
            loc_response = 'error';
          ELSE
            UPDATE contacts
            SET c_number = par_c_number, name = par_name, l_name = par_l_name
                              
            WHERE contact_id = par_contact_id;

          END IF;
      END IF;

      RETURN loc_response;
    END;
    $$ LANGUAGE 'plpgsql';

  --select * from upsert_contact('09359145088', 'Liza', 'Soberano');

  create or replace function getcontacts(In par_contact_id INT) RETURNS SETOF contacts AS

  $$
    BEGIN
    IF par_contact_id ISNULL
    THEN
      RETURN QUERY SELECT * FROM contacts;
    ELSE
      RETURN QUERY SELECT * FROM contacts WHERE contact_id = par_contact_id;

    END IF;
  END;
  $$ LANGUAGE 'plpgsql';
