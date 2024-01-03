-- Data Definition Language (DDL) Statements

-- Create Table
-- Syntax:
-- CREATE TABLE table_name ( col_name_1 DATATYPE, col_name_2 DATATYPE, etc.)
-- table_name -> all lower case and singular form

-- Create a table for our blog users
CREATE TABLE IF NOT EXISTS blog_user (
	-- Column Name DataType <Constraints>
	user_id SERIAL PRIMARY KEY, -- PRIMARY KEY specifies BOTH UNIQUE AND NOT NULL
	username VARCHAR(25) NOT NULL UNIQUE, -- NOT NULL means that this COLUMN cannot be a NULL value
	password_hash VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	first_name VARCHAR, -- WITHOUT specifying, can be NULL AND NOT unique
	last_name VARCHAR
);

SELECT *
FROM blog_user;

-- To make any changes to a table after it has been created, use the ALTER statement

-- Rename a Column:
-- ALTER TABLE table_name RENAME COLUMN current_column_name TO new_column_name
ALTER TABLE blog_user
RENAME COLUMN email TO email_address;


-- Add a Column:
-- ALTER TABLE table_name ADD COLUMN new_col_name DataType
ALTER TABLE blog_user
ADD COLUMN middle_name VARCHAR;


-- Change a Column's DataType
-- ALTER TABLE table_name ALTER COLUMN col_name TYPE new_datatype;
ALTER TABLE blog_user
ALTER COLUMN email_address TYPE VARCHAR(30);


-- Create Post Table with a FK to Blog User Table
CREATE TABLE IF NOT EXISTS post(
	post_id SERIAL PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	body VARCHAR NOT NULL,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	-- Step 1: Create the column alone
	user_id INTEGER NOT NULL,
	-- Step 2: Add Foreign Key to the new column
	-- Syntax: FOREIGN KEY(col_in_domestic_table) REFERENCES foreign_table_name(col_in_foreign_table)
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id)
);

SELECT *
FROM post;


-- Create Post-Category Join Table
CREATE TABLE post_category (
	post_id INTEGER NOT NULL,
	FOREIGN KEY(post_id) REFERENCES post(post_id),
	category_id INTEGER NOT NULL
	-- FOREIGN KEY(category_id) REFERENCES category(category_id) -- CANNOT REFERENCE a table that does not exist!
);

-- Create the Category Table
CREATE TABLE category (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(25) NOT NULL,
	description VARCHAR(100) NOT NULL
);

-- Now that the category table exists, we can add the FK from post_category
-- ALTER TABLE table_name 
-- ADD FOREIGN KEY(col_in_domestic_table) REFERENCES foreign_table_name(col_in_foreign_table)
ALTER TABLE post_category
ADD FOREIGN KEY(category_id) REFERENCES category(category_id);

-- Create the comment table
CREATE TABLE post_comment (
	comment_id SERIAL PRIMARY KEY,
	body VARCHAR NOT NULL,
	date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	user_id INTEGER NOT NULL,
	FOREIGN KEY(user_id) REFERENCES blog_user(user_id),
	post_id INTEGER NOT NULL,
	FOREIGN KEY(post_id) REFERENCES post(post_id)
);



-- Create a table that we will eventually delete
CREATE TABLE delete_me (
	test_id SERIAL PRIMARY KEY,
	col_1 INTEGER,
	col_2 BOOLEAN
);

SELECT *
FROM delete_me;


-- Remove a column from a table
-- Syntax: ALTER TABLE table_name DROP COLUMN col_name;
ALTER TABLE delete_me 
DROP COLUMN col_1;


-- Remove a table completely, use DROP TABLE table_name
DROP TABLE IF EXISTS delete_me;
