set search_path to classicmodels, public;

-- Nomor 1
SELECT 
    customernumber,
    SUM(amount) AS total_akumulasi_dana,
    COUNT(checknumber) AS jumlah_frekuensi_transaksi,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;

-- Nomor 2
SELECT
	customernumber,
	SUM(amount) AS total_dana
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_dana DESC;

-- Nomor 3
SELECT 
    productline AS kategori_barang,
    COUNT(productcode) AS jumlah_ragam_produk,
    ROUND(AVG(msrp), 2) AS rata_rata_harga_jual,
    STRING_AGG(productname, ', ' ORDER BY productname) AS daftar_nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

-- Nomor 4
SELECT DISTINCT reportsto AS Nomor_Karyawan
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle ILIKE '%VP%' OR jobTitle ILIKE '%President%';

-- Nomor 5
SELECT 
    productcode,
    SUM(quantityordered) AS total_unit_terjual,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga_jual
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_unit_terjual DESC;

-- Nomor 6
SELECT 
    productcode,
    SUM(quantityordered) AS total_unit_terjual,
    SUM(quantityordered * priceeach) AS total_pendapatan_kotor,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga_jual,
    MAX(priceeach) - MIN(priceeach) AS rentang_volatilitas_harga
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY total_pendapatan_kotor DESC;

-- Nomor 7
SELECT customernumber
FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber
FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold'
EXCEPT
SELECT customernumber
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000;
