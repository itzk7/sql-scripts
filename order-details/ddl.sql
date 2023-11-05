CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE product (
	product_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
	name TEXT NOT NULL,
	description TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE customer (
	customer_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
	name TEXT NOT NULL,
	email TEXT NOT NULL,
	phone_number TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE address (
	address_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
	line1 TEXT NOT NULL,
	line2 TEXT NOT NULL,
	pincode TEXT NOT NULL,
	state TEXT NOT NULL,
	city TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE customer_address (
	customer_id uuid REFERENCES customer(customer_id),
	address_id uuid REFERENCES address(address_id),
	PRIMARY KEY (customer_id, address_id)
);

CREATE TABLE customer_order (
	order_id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
	customer_id uuid REFERENCES customer(customer_id),
	shipping_address_id uuid REFERENCES address(address_id),
	created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE order_item (
	order_id uuid REFERENCES customer_order(order_id),
	product_id uuid REFERENCES product(product_id),
	quantity INT NOT NULL DEFAULT 1,
	PRIMARY KEY (order_id, product_id)
);

CREATE TABLE order_details_view (
	order_id uuid PRIMARY KEY DEFAULT uuid_generate_v4() REFERENCES customer_order(order_id),
	ordered_at TIMESTAMP NOT NULL,
	customer_id uuid REFERENCES customer(customer_id),
	customer_name TEXT NOT NULL,
	email TEXT NOT NULL,
	phone_number TEXT NOT NULL,
	address json,
	products json
);

INSERT INTO
	product (
		product_id,
		"name",
		description,
		created_at,
		updated_at
	)
VALUES
	(
		'7d156c46-180c-4c84-80e6-f183164f5a7c',
		'Kunai',
		'A small, versatile throwing knife that can also be used for hand-to-hand combat.',
		'2023-10-26 22:43:28.870904',
		'2023-10-26 22:43:28.870904'
	),
	(
		'7790402b-d4ca-41df-a092-743349f44f29',
		'Shuriken',
		'A star-shaped throwing weapon that is often used in conjunction with kunai.',
		'2023-10-26 22:43:28.870904',
		'2023-10-26 22:43:28.870904'
	),
	(
		'8471b90c-c55a-46f9-b352-13524ca82497',
		'Explosive Tags',
		'Paper tags that can be attached to surfaces or people and detonated remotely.',
		'2023-10-26 22:43:28.870904',
		'2023-10-26 22:43:28.870904'
	),
	(
		'c81980ba-33fe-4eb6-9fe6-2b0db77a9f2b',
		'Smoke Bombs',
		'Bombs that release a thick cloud of smoke, which can be used to obscure one''s vision or create a diversion.',
		'2023-10-26 22:43:28.870904',
		'2023-10-26 22:43:28.870904'
	),
	(
		'76725a99-51d5-433e-8c88-11d1de0d188a',
		'Senbon',
		'Thin, needle-like projectiles that can be used to deliver poison or acupuncture.',
		'2023-10-26 22:43:28.870904',
		'2023-10-26 22:43:28.870904'
	);

INSERT INTO
	customer (
		customer_id,
		"name",
		email,
		phone_number,
		created_at,
		updated_at
	)
VALUES
	(
		'49e7b03e-9566-4a3e-904b-0c54aceff18d',
		'Hashirama Senju',
		'hashirama@shinobiworld.in',
		'3232392392',
		'2023-10-26 21:03:56.67626',
		'2023-10-26 21:03:56.67626'
	),
	(
		'5bb53597-6e7b-4bb8-89c0-bddd1ee46576',
		'Tobirama Senju',
		'tobirama@shinobiworld.in',
		'3232392391',
		'2023-10-26 21:03:56.67626',
		'2023-10-26 21:03:56.67626'
	),
	(
		'f1431e46-d4cd-4782-abf4-67fbceba16b5',
		'Hiruzen Sarutobi',
		'hiruzen@shinobiworld.in',
		'3232392393',
		'2023-10-26 21:03:56.67626',
		'2023-10-26 21:03:56.67626'
	),
	(
		'd977d42f-21a6-4a54-8355-db9cfbfcc9b6',
		'Minato Namikaze',
		'minato@shinobiworld.in',
		'3232392394',
		'2023-10-26 21:03:56.67626',
		'2023-10-26 21:03:56.67626'
	);

INSERT INTO
	address (
		address_id,
		line1,
		line2,
		pincode,
		state,
		city,
		created_at,
		updated_at
	)
VALUES
	(
		'1ce54feb-c6af-49d3-b586-c70e601abc6e',
		'lord 1st home',
		'Senju street',
		'392391',
		'TK-JP',
		'Hidden Leaf village',
		'2023-10-26 22:47:48.072365',
		'2023-10-26 22:47:48.072365'
	),
	(
		'825aba46-ca7c-4320-8adb-50d171c75c3c',
		'lord 2nd home',
		'Senju street',
		'392391',
		'TK-JP',
		'Hidden Leaf village',
		'2023-10-26 22:47:48.072365',
		'2023-10-26 22:47:48.072365'
	),
	(
		'd7e7762e-394d-414c-b84a-36c1a5543f03',
		'lord 3rd home',
		'Sarutobi street',
		'392692',
		'TK-JP',
		'Hidden Leaf village',
		'2023-10-26 22:47:48.072365',
		'2023-10-26 22:47:48.072365'
	),
	(
		'dec65be9-baef-4228-8984-6e8fc1553a97',
		'lord 1st home',
		'Namikaze street',
		'392399',
		'TK-JP',
		'Hidden Leaf village',
		'2023-10-26 22:47:48.072365',
		'2023-10-26 22:47:48.072365'
	);

INSERT INTO
	customer_address (customer_id, address_id)
VALUES
	(
		'49e7b03e-9566-4a3e-904b-0c54aceff18d',
		'1ce54feb-c6af-49d3-b586-c70e601abc6e'
	),
	(
		'5bb53597-6e7b-4bb8-89c0-bddd1ee46576',
		'825aba46-ca7c-4320-8adb-50d171c75c3c'
	),
	(
		'f1431e46-d4cd-4782-abf4-67fbceba16b5',
		'd7e7762e-394d-414c-b84a-36c1a5543f03'
	),
	(
		'd977d42f-21a6-4a54-8355-db9cfbfcc9b6',
		'dec65be9-baef-4228-8984-6e8fc1553a97'
	);

INSERT INTO
	customer_order (
		order_id,
		customer_id,
		shipping_address_id,
		created_at
	)
VALUES
	(
		'c309d8a9-33cc-4011-8027-2ade7b8c8074',
		'49e7b03e-9566-4a3e-904b-0c54aceff18d',
		'1ce54feb-c6af-49d3-b586-c70e601abc6e',
		'2023-10-26 23:00:38.324566'
	),
	(
		'd58b3367-dea9-4174-bdf1-1eeff50f4df3',
		'49e7b03e-9566-4a3e-904b-0c54aceff18d',
		'1ce54feb-c6af-49d3-b586-c70e601abc6e',
		'2023-10-26 23:00:38.324566'
	),
	(
		'd618169b-5a5e-4f40-9e08-0a25c26be14b',
		'5bb53597-6e7b-4bb8-89c0-bddd1ee46576',
		'825aba46-ca7c-4320-8adb-50d171c75c3c',
		'2023-10-26 23:00:38.324566'
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'f1431e46-d4cd-4782-abf4-67fbceba16b5',
		'd7e7762e-394d-414c-b84a-36c1a5543f03',
		'2023-10-26 23:00:38.324566'
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'd977d42f-21a6-4a54-8355-db9cfbfcc9b6',
		'dec65be9-baef-4228-8984-6e8fc1553a97',
		'2023-10-26 23:00:38.324566'
	);

INSERT INTO
	order_item (order_id, product_id, quantity)
VALUES
	(
		'c309d8a9-33cc-4011-8027-2ade7b8c8074',
		'7d156c46-180c-4c84-80e6-f183164f5a7c',
		10
	),
	(
		'c309d8a9-33cc-4011-8027-2ade7b8c8074',
		'7790402b-d4ca-41df-a092-743349f44f29',
		100
	),
	(
		'd58b3367-dea9-4174-bdf1-1eeff50f4df3',
		'8471b90c-c55a-46f9-b352-13524ca82497',
		120
	),
	(
		'd58b3367-dea9-4174-bdf1-1eeff50f4df3',
		'76725a99-51d5-433e-8c88-11d1de0d188a',
		1012
	),
	(
		'd58b3367-dea9-4174-bdf1-1eeff50f4df3',
		'c81980ba-33fe-4eb6-9fe6-2b0db77a9f2b',
		12
	),
	(
		'd618169b-5a5e-4f40-9e08-0a25c26be14b',
		'7790402b-d4ca-41df-a092-743349f44f29',
		142
	),
	(
		'd618169b-5a5e-4f40-9e08-0a25c26be14b',
		'76725a99-51d5-433e-8c88-11d1de0d188a',
		132
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'7d156c46-180c-4c84-80e6-f183164f5a7c',
		20
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'7790402b-d4ca-41df-a092-743349f44f29',
		1300
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'8471b90c-c55a-46f9-b352-13524ca82497',
		1210
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'76725a99-51d5-433e-8c88-11d1de0d188a',
		1212
	),
	(
		'9128db81-3b53-40e9-b80b-6203f9c077fa',
		'c81980ba-33fe-4eb6-9fe6-2b0db77a9f2b',
		122
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'7d156c46-180c-4c84-80e6-f183164f5a7c',
		2022
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'7790402b-d4ca-41df-a092-743349f44f29',
		130022
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'8471b90c-c55a-46f9-b352-13524ca82497',
		12102
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'76725a99-51d5-433e-8c88-11d1de0d188a',
		12121
	),
	(
		'd4d7ce2d-fdb2-4564-8af2-35ef2fb56145',
		'c81980ba-33fe-4eb6-9fe6-2b0db77a9f2b',
		1222
	);
