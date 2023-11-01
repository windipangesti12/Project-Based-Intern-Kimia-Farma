-- Create Database
CREATE DATABASE IF NOT EXISTS kimia_farma;
USE kimia_farma;

-- Create Table Penjualan
CREATE TABLE penjualan(
	id_distributor VARCHAR(45),
    id_cabang VARCHAR(45),
    id_invoice VARCHAR(45),
    tanggal DATE,
    id_customer VARCHAR(45),
    id_barang VARCHAR(45),
    jumlah_barang INT,
    unit VARCHAR(45),
    harga INT,
    mata_uang VARCHAR(5),
    brand_id VARCHAR(45),
    lini VARCHAR(45),
    PRIMARY KEY(id_invoice));

-- Create Table barang
CREATE TABLE barang(
	kode_barang VARCHAR(45),
	sektor CHAR,
	nama_barang VARCHAR(45),
	tipe VARCHAR(45),
	nama_tipe VARCHAR(45),
	kode_lini INT,
	lini VARCHAR(45),
	kemasan VARCHAR(45),
    PRIMARY KEY (kode_barang));

-- Create Table Pelanggan
CREATE TABLE pelanggan(
	id_customer VARCHAR(45),
    levels VARCHAR(45),
    nama VARCHAR(45),
    id_cabang_sale VARCHAR(45),
    cabang_sales VARCHAR(45),
    id_group VARCHAR(45),
    grup VARCHAR(45),
    PRIMARY KEY(id_customer));
    
SELECT * FROM pelanggan

-- Create base table
-- Join table penjualan, barang, and pelanggan into one table called base_table

CREATE TABLE base_table (
SELECT
    pjl.id_invoice,
    pjl.tanggal,
    pjl.id_barang,
    brg.nama_barang,
    pjl.harga,
    pjl.unit,
    pjl.jumlah_barang,
    pjl.mata_uang,
    brg.kode_barang,
    pjl.brand_id,
    brg.kode_lini,
    pjl.lini,
    pjl.id_customer,
    plg.nama,
    plg.cabang_sales,
    plg.id_cabang_sale,
    pjl.id_distributor,
    plg.grup
FROM penjualan pjl
	LEFT JOIN barang brg
		ON pjl.id_barang = brg.kode_barang
	LEFT JOIN pelanggan plg
		ON pjl.id_customer = plg.id_customer
);

-- Set Primary Key
ALTER TABLE base_table ADD PRIMARY KEY(id_invoice);
SELECT * FROM base_table

-- Create Aggregate Table
CREATE TABLE agg_table (
SELECT 
    tanggal,
    id_invoice, 
    id_customer, 
    nama AS customer, 
    nama_barang,
    cabang_sales,
    lini AS brand,
    grup AS category,
    id_distributor,
    harga,
    jumlah_barang,
    (harga * jumlah_barang) AS Total_pendapatan
FROM base_table
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
ORDER BY 1
);

-- Export Table Queries to CSV
