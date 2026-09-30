CREATE TABLE prodi (
	id_prodi INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nama VARCHAR(100) NOT NULL,
	nim VARCHAR(10) PRIMARY KEY,
	ipk NUMERIC(3,2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi (id_prodi)
);

INSERT INTO prodi (nama_prodi)
VALUES ('Sistem Informasi');

INSERT INTO mahasiswa (nama, nim, ipk, email, id_prodi)
VALUES 
	('Aqilah', 'MHS01', 3.50, 'aqilah@gmail.com', 1),
	('Riskia', 'MHS02', NULL, 'kiaa@gmail.com', 1),
	('Addah', 'MHS03', 3.50, NULL, 1),
	('Zahrah', 'MHS04', 3.50, 'taesance@gmail.com', 1),
	('Alifah', 'MHS05', NULL, 'alifahh@gmail.com', 1);

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING *;

SET search_path TO classicmodels, public;

SELECT 
	customerNumber AS "Nomor Pelanggan", 
	customerName AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara" 
FROM customers;

SELECT productCode, productName, buyPrice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country
LIMIT 5 OFFSET 5;
