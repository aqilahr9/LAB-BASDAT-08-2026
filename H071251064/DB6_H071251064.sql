SET search_path TO classicmodels, public;

-- Nomor 1
SELECT 
    productcode, 
    productname, 
    msrp, 
    quantityinstock, 
    CASE 
        WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
        WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
        WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
        WHEN msrp > 100 THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY msrp DESC;

-- Nomor 2
SELECT 
	productcode, 
	SUM(quantityOrdered) AS total_unit_terjual, 
	COUNT (DISTINCT orderNumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productcode
HAVING SUM (quantityordered) > (
    SELECT AVG(quantityordered) FROM orderdetails ) AND
    COUNT (DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

-- Nomor 3
SELECT 
    productcode, 
    productname, 
    quantityinstock, 
    msrp
FROM products
WHERE quantityinstock > (SELECT AVG(quantityinstock) FROM products)
  AND msrp > (SELECT AVG(msrp) FROM products)
ORDER BY quantityinstock DESC;

-- Nomor 4
BEGIN;

UPDATE orders 
SET status = 'Pengiriman' 
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders 
SET status = 'Batal' 
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- Nomor 5
CREATE TABLE anggota (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INT,
	CONSTRAINT fk_anggota_peminjaman
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
    id_buku INT,
	CONSTRAINT fk_buku_peminjaman
		FOREIGN KEY (id_buku)
		REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0
);

CREATE INDEX genre ON buku(genre);
CREATE INDEX kota ON anggota(kota_domisili);