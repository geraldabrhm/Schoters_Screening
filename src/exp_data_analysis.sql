---- 2 Required query
-- 2a) Total transaksi dari masing-masing customer
SELECT id_customer, nama_customer, SUM(harga_asli) AS total_transaksi FROM transaksi
NATURAL JOIN customer
GROUP BY customer.id_customer
ORDER BY total_transaksi DESC;

-- 2b) Total transaksi dari masing-masing kota
SELECT domisili AS wilayah, SUM(harga_asli) AS total_transaksi FROM transaksi
NATURAL JOIN customer
GROUP BY domisili
ORDER BY total_transaksi DESC;

---- 3 Exploratory Data Analysis
--- Dataset - Count null values from each table
-- Count null values from table transaksi
SELECT SUM(ISNULL(id_transaction)) AS count_null_id_trx,
SUM(ISNULL(id_customer)) AS count_null_id_cust,
SUM(ISNULL(tanggal_transaksi)) AS count_null_date_trx,
SUM(ISNULL(nama_sales)) AS count_null_sales,
SUM(ISNULL(harga_asli)) AS count_null_price,
SUM(ISNULL(tipe_produk)) AS count_null_prod
FROM transaksi;

-- Count null values from table campaign
SELECT SUM(ISNULL(campaign_name)) AS count_null_campaign,
SUM(ISNULL(start_date)) AS count_null_start_date,
SUM(ISNULL(end_date)) AS count_null_end_date,
SUM(ISNULL(budget)) AS count_null_budget
FROM campaign;

-- Count null values from table customer
SELECT SUM(ISNULL(id_customer)) AS count_null_cust_id,
SUM(ISNULL(nama_customer)) AS count_null_cust_name,
SUM(ISNULL(domisili)) AS count_null_domisili,
SUM(ISNULL(campaign_engage)) AS count_null_engage
FROM customer;

--- Dataset -  Get the shape of each table
-- Row size from table campaign
SELECT COUNT(*) AS row_size FROM campaign;
-- Column size from table campaign
SELECT COUNT(*) AS columns_size
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'schoters'
AND TABLE_NAME = 'campaign';

-- Row size from table customer
SELECT COUNT(*) AS row_size FROM customer;
-- Column size from table campaign
SELECT COUNT(*) AS columns_size
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'schoters'
AND TABLE_NAME = 'customer';

-- Row size from table campaign
SELECT COUNT(*) AS row_size FROM transaksi;
-- Column size from table campaign
SELECT COUNT(*) AS columns_size
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'schoters'
AND TABLE_NAME = 'transaksi';

--- Insight - Get total transaction each month
SELECT DATE_FORMAT(tanggal_transaksi, "%M %Y") AS Bulan_Tahun, 
SUM(harga_asli) AS Total_Transaksi 
FROM transaksi 
GROUP BY YEAR(tanggal_transaksi), MONTH(tanggal_transaksi)
ORDER BY YEAR(tanggal_transaksi), MONTH(tanggal_transaksi);

--- Insight - Get total transaction each year
SELECT YEAR(tanggal_transaksi) AS Tahun, 
SUM(harga_asli) AS Total_Transaksi 
FROM transaksi 
GROUP BY YEAR(tanggal_transaksi)
ORDER BY YEAR(tanggal_transaksi);

--- Insight - Get total transaction based on tipe_produk dan melihat urutan produk yang total transaksinya tertinggi
SELECT tipe_produk, SUM(harga_asli) AS total_transaksi
FROM transaksi
GROUP BY tipe_produk
ORDER BY total_transaksi DESC;

--- Insight - Get nama_sales dengan total_transaksi dan frekuensi transaksi yang diurus berurutan dari yang terbanyak total_transaksinya
SELECT nama_sales, 
SUM(harga_asli) AS total_transaksi, COUNT(harga_asli) AS banyak_transaksi
FROM transaksi
GROUP BY nama_sales
ORDER BY total_transaksi DESC;

--- Insight - Get banyak customer dari tiap wilayah dan diurutkan dari yang terbanyak
SELECT domisili AS wilayah, COUNT(id_customer) AS banyak_customer
FROM customer
GROUP BY wilayah
ORDER BY banyak_customer DESC;

--- Insight - Get rentang usia pelanggan
SELECT
	SUM(CASE WHEN usia < 20 THEN 1 ELSE 0 END) AS '<20',
	SUM(CASE WHEN usia BETWEEN 20 AND 30 THEN 1 ELSE 0 END) AS '20-30',
    SUM(CASE WHEN usia BETWEEN 30 AND 40 THEN 1 ELSE 0 END) AS '30-40',
    SUM(CASE WHEN usia > 40 THEN 1 ELSE 0 END) AS '>40'
FROM customer;

-- Insight - Mendapatkan perbandingan budget yang dikeluarkan dengan total transaksi
(SELECT DATE_FORMAT(tanggal_transaksi, "%M %Y") AS bulan_tahun,
budget,
SUM(harga_asli) AS total_transaksi
FROM transaksi
RIGHT JOIN campaign ON DATE_FORMAT(tanggal_transaksi, "%m") = DATE_FORMAT(campaign.start_date, "%m")
GROUP BY YEAR(tanggal_transaksi), MONTH(tanggal_transaksi)
ORDER BY YEAR(tanggal_transaksi), MONTH(tanggal_transaksi));