-- Load Data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Campaign.csv' 
INTO TABLE campaign
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(campaign_name, @start_date, @end_date, @budget)
SET start_date = STR_TO_DATE(@start_date, '%e/%c/%Y'),
end_date = STR_TO_DATE(@end_date, '%e/%c/%Y'),
budget = REPLACE(REPLACE(@budget, ',', ''), 'Rp', '');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customer.csv' 
INTO TABLE customer
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nama, @domisili, @usia)
SET nama_customer = @nama,
domisili = @domisili,
usia = @usia;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Transaksi.csv' 
INTO TABLE transaksi
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@tanggal_transaksi, @nama_sales, @harga_asli, @customer, @tipe_produk)
SET tanggal_transaksi = STR_TO_DATE(@tanggal_transaksi, '%e/%c/%Y'),
nama_sales = @nama_sales,
harga_asli = (SELECT IF(@harga_asli != '', REPLACE(REPLACE(@harga_asli, ',', ''), 'Rp', ''), NULL)),
tipe_produk = @tipe_produk,
id_customer = (SELECT id_customer FROM customer WHERE customer.nama_customer = @customer);