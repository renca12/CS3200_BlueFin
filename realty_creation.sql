-- ================================== Create Database, Tables, and Attributes ==================================
DROP DATABASE IF EXISTS realty;
CREATE DATABASE IF NOT EXISTS realty;

USE realty; 

DROP TABLE IF EXISTS management_company;
CREATE TABLE management_company(
management_company_id INT PRIMARY KEY AUTO_INCREMENT,
management_company_name VARCHAR(45));


DROP TABLE IF EXISTS realtor;
CREATE TABLE realtor(
realtor_id INT PRIMARY KEY AUTO_INCREMENT,
realtor_firstname VARCHAR (45),
realtor_lastname VARCHAR (45),
realtor_age VARCHAR (45),
management_company_id INT,
FOREIGN KEY (management_company_id) REFERENCES management_company(management_company_id));

DROP TABLE IF EXISTS seller;
CREATE TABLE seller(
seller_id INT PRIMARY KEY AUTO_INCREMENT,
seller_firstname VARCHAR (45),
seller_lastname VARCHAR (45));

DROP TABLE IF EXISTS buyer;
CREATE TABLE buyer(
buyer_id INT PRIMARY KEY AUTO_INCREMENT,
has_partner TINYINT,
num_kids INT,
buyer_firstname VARCHAR (45),
buyer_lastname VARCHAR (45));

DROP TABLE IF EXISTS zip_code;
CREATE TABLE zip_code(
zip_code_id INT PRIMARY KEY,
avg_property_tax INT,
region VARCHAR(45),
state VARCHAR(45));

DROP TABLE IF EXISTS seller_realtor_relation;
CREATE TABLE seller_realtor_relation(
seller_realtor_relation_id INT PRIMARY KEY AUTO_INCREMENT,
seller_id INT,
realtor_id INT,
FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
FOREIGN KEY (realtor_id) REFERENCES realtor(realtor_id));

DROP TABLE IF EXISTS buyer_realtor_relation;
CREATE TABLE buyer_realtor_relation(
buyer_realtor_relation_id INT PRIMARY KEY AUTO_INCREMENT,
buyer_id INT,
realtor_id INT,
FOREIGN KEY (buyer_id) REFERENCES buyer(buyer_id),
FOREIGN KEY (realtor_id) REFERENCES realtor(realtor_id));

DROP TABLE IF EXISTS property;
CREATE TABLE property(
property_id INT PRIMARY KEY AUTO_INCREMENT,
sq_ft INT,
num_bed INT,
num_bath FLOAT,
availability TINYINT,
type ENUM('apartment', 'house', 'studio', 'condo'),
jobs_accessible_by_pt TINYINT,
nearby_pt TINYINT,
walkability INT,
in_school_zone TINYINT,
flood_factor INT,
address VARCHAR (45),
zip_code_id INT,
seller_id INT,
FOREIGN KEY (seller_id) REFERENCES seller(seller_id),
FOREIGN KEY (zip_code_id) REFERENCES zip_code(zip_code_id));

DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction(
transaction_id INT PRIMARY KEY AUTO_INCREMENT,
seller_asking_price INT,
buyer_asking_price INT,
got_property TINYINT,
sell_price INT,
offer_date DATE,
sell_date DATE,
property_id INT,
buyer_realtor_relation_id INT,
seller_realtor_relation_id INT,
FOREIGN KEY (property_id) REFERENCES property(property_id),
FOREIGN KEY (buyer_realtor_relation_id) REFERENCES buyer_realtor_relation(buyer_realtor_relation_id),
FOREIGN KEY (seller_realtor_relation_id) REFERENCES seller_realtor_relation(seller_realtor_relation_id));

-- =================================================== Data Insertion ===================================================
INSERT INTO management_company(management_company_id, management_company_name) VALUES
(1, 'Photon Mgmt'),
(2, 'Real Bros Real Estate'),
(3, 'Garbs Inc');

INSERT INTO realtor(realtor_id, realtor_firstname, realtor_lastname, realtor_age, management_company_id) VALUES
(1, 'Jimbo', 'Jorges', '67', 1),
(2, 'Big', 'Nate', '13', 1),
(3, 'George', 'Jumbotron', '44', 2),
(4, 'Geoff', 'Jumbotron', '47', 2),
(5, 'Timmy', 'Jumbotron', '38', 2),
(6, 'Garbanzo', 'Beans', '37', 3);

-- SELECT r.realtor_firstname 
-- FROM realtor r
-- INNER JOIN management_company m
-- ON r.management_company_id = m.management_company_id
-- WHERE m.management_company_name = 'Photon Mgmt';

INSERT INTO seller(seller_id, seller_firstname, seller_lastname) VALUES
(1, 'John', 'Snow'),
(2, 'Bee', 'Doe'),
(3, 'Kyle', 'Smith'),
(4, 'Papa', 'John'),
(5, 'Papa', 'Smurf'),
(6, 'Baby', 'Mario'),
(7, 'Frederick', 'Leach'),
(8, 'Franz', 'Ferdinand'),
(9, 'Aero', 'Smith'),
(10, 'Iron', 'Smith'),
(11, 'Steve', 'From-Minecraft'),
(12, 'Austin', 'Wedge'),
(13, 'Kyle', 'Shanahan'),
(14, 'Jake', 'Lyon'),
(15, 'Scooby', 'Doo'),
(16, 'Priss', 'Chratt'),
(17, 'Harry', 'Potter'),
(18, 'Sneverus', 'Ape'),
(19, 'Ariana', 'Grande'),
(20, 'Matt', 'Champion'),
(21, 'Joe', 'Hardy'),
(22, 'Tom', 'Hardy'),
(23, 'Chet', 'Morgan'),
(24, 'Perry', 'Playtpus');

INSERT INTO buyer(buyer_id, has_partner, num_kids, buyer_firstname, buyer_lastname) VALUES
(1, 0, 0, 'Fransisco', 'Lindor'),
(2, 1, 3, 'Frank', 'Hughes'),
(3, 1, 2, 'Walter', 'White'),
(4, 1, 5, 'Jeff', 'Bezos'),
(5, 0, 0, 'Bruce', 'Lee'),
(6, 0, 0, 'Tiffany', 'Day'),
(7, 0, 0, 'Kenny', 'Olzewski'),
(8, 1, 0, 'Humbridge', 'Beauregard'),
(9, 1, 0, 'Kathleen', 'Kennedy'),
(10, 1, 0, 'Petunia', 'Prior'),
(11, 1, 1, 'Jacob', 'Spelt'),
(12, 1, 4, 'Ugo', 'Massaia'),
(13, 0, 0, 'Riana', 'Chen'),
(14, 0, 0, 'Steven', 'Cho'),
(15, 0, 0, 'Tim', 'Anderson'),
(16, 1, 0, 'Salvador', 'Perez'),
(17, 1, 0, 'Puka', 'Nacua'),
(18, 1, 1, 'Shohei', 'Ohtani'),
(19, 1, 2, 'Terrance', 'Foster'),
(20, 0, 0, 'El', 'Jefes'),
(21, 1, 2, 'Sir', 'Duke'),
(22, 0, 3, 'Jared', 'Goff'),
(23, 1, 1, 'James', 'Rodriguez'),
(24, 1, 0, 'Jamhyr', 'Gibbs'),
(25, 0, 2, 'Jameson', 'Williams'),
(26, 1, 4, 'Emma', 'Williams'),
(27, 0, 0, 'Alex', 'Kim'),
(28, 1, 2, 'Sofia', 'Martinez'),
(29, 1, 3, 'Patrick', 'Star'),
(30, 0, 1, 'Lester', 'Holt');

INSERT INTO zip_code(zip_code_id, avg_property_tax, region, state) VALUES
(02120, 8422, 'Suffolk', 'MA'),
(01740, 12636, 'Worcestor', 'MA'),
(02019, 4748, 'Norfolk', 'MA'),
(02744, 10157, 'Bristol', 'MA'),
(02739, 9886, 'Plymouth', 'MA'),
(02115, 9015, 'Suffolk', 'MA');

INSERT INTO seller_realtor_relation(seller_realtor_relation_id, seller_id, realtor_id) VALUES
(1, 1, 4),
(2, 2, 2),
(3, 3, 2),
(4, 4, 1),
(5, 5, 5),
(6, 6, 5),
(7, 7, 5),
(8, 8, 3),
(9, 9, 5),
(10, 10, 5),
(11, 11, 1),
(12, 12, 1),
(13, 13, 4),
(14, 14, 2),
(15, 15, 2),
(16, 16, 5),
(17, 17, 1),
(18, 18, 3),
(19, 19, 6),
(20, 20, 6),
(21, 21, 2),
(22, 22, 5),
(23, 23, 2),
(24, 24, 1);

INSERT INTO buyer_realtor_relation(buyer_realtor_relation_id, buyer_id, realtor_id) VALUES
(1 , 1, 1),
(2 , 2, 2),
(3 , 3, 2),
(4 , 4, 5),
(5 , 5, 5),
(6 , 6, 5),
(7 , 7, 4),
(8 , 8, 4),
(9 , 9, 5),
(10 , 10, 5),
(11 , 11, 1),
(12 , 12, 2),
(13 , 13, 3),
(14 , 14, 2),
(15 , 15, 5),
(16 , 16, 5),
(17 , 17, 3),
(18 , 18, 2),
(19 , 19, 4),
(20 , 20, 1),
(21, 21, 2),
(22, 22, 3),
(23, 23, 2),
(24, 24, 4),
(25, 25, 1),
(26, 26, 3),
(27, 27, 5),
(28, 28, 2),
(29, 29, 4),
(30, 30, 6);


INSERT INTO property(property_id, sq_ft, num_bed, num_bath,
availability, type, jobs_accessible_by_pt, nearby_pt, walkability, in_school_zone, flood_factor,
address, zip_code_id, seller_id) VALUES
(1, 1200, 2, 2, 1, 'apartment', 1, 1, 85, 1, 15, '245 Belleview Ave', '02120', 1),
(2, 2500, 4, 3, 1, 'house', 1, 0, 45, 1, 8, '1823 Greenbrier Dr', '01740', 2),
(3, 850, 1, 1, 1, 'studio',0, 1, 92, 0, 22, '67 Proton St',  '02115', 3),
(4, 1800, 3, 2, 1, 'condo', 1, 1, 78, 1, 12, '456 Main St', '02019', 4),
(5, 3200, 5, 4, 0, 'house',0, 0, 35, 1, 5, '2901 Wherewithal Ave', '02744', 5),
(6, 1500, 2, 2, 1, 'apartment', 1, 1, 88, 1, 18, '789 Easy St', '02739', 6),
(7, 950, 1, 1, 1, 'studio',1,  1, 95, 0, 25, '134 Huntington Ave', '02115', 7),
(8, 2100, 3, 2, 1, 'house',1,  0, 52, 1, 10, '1567 Midcourt Pl', '02744', 8),
(9, 1350, 2, 1, 1, 'condo', 1, 1, 81, 1, 14, '892 Oner Blvd',  '02019', 9),
(10, 2800, 4, 3, 1, 'house', 0, 0, 40, 1, 7, '2145 Adele St', '01740', 10),
(11, 1100, 2, 1, 1, 'apartment',1, 1, 90, 0, 20, '445 Frankfurt St', '02120', 11),
(12, 750, 1, 1, 1, 'studio',1, 1, 98, 1, 30, '89 Wright St', '02115', 12),
(13, 1650, 2, 2, 1, 'condo',0, 1, 75, 1, 16, '678 Preston Rd', '01740', 13),
(14, 2300, 3, 2, 1, 'house',1, 0, 48, 1, 9, '1734 Easton Rd', '01740', 14),
(15, 1400, 2, 2, 1, 'apartment', 1, 1, 86, 1, 19, '523 Louisville St', '02744', 5),
(16, 3500, 5, 4, 0, 'house',1, 0, 28, 0, 4, '3102 Lullaby Pl', '02019', 16),
(17, 1950, 3, 2, 0, 'condo',1, 1, 72, 1, 11, '1045 Drexel St', '02019', 17),
(18, 2600, 4, 3, 0, 'house',0, 0, 38, 1, 6, '2456 Banana St', '02739', 18),
(19, 12500, 4, 4.5, 1, 'house',1, 1, 65, 1, 12, '86 Parcel Pt', '02019', 19),
(20, 1500, 3, 1, 1, 'apartment',1, 1, 89, 1, 50, '920 Piltover Rd', '02115', 20),
(21, 1750, 2, 2, 1, 'condo', 1, 1, 83, 1, 13, '312 Harbor View Dr', '02120', 21),
(22, 2900, 4, 3, 1, 'house', 0, 0, 42, 1, 8, '1678 Oakmont Ave', '02744', 22),
(23, 1050, 1, 1, 1, 'studio', 1, 1, 94, 0, 28, '551 Commonwealth Ave', '02115', 23),
(24, 2200, 3, 2, 0, 'house', 1, 0, 55, 1, 10, '2834 Riverside Ln', '01740', 24),
(25, 1600, 2, 2, 1, 'apartment', 1, 1, 87, 1, 17, '467 Beacon St', '02739', 24) ;

INSERT INTO transaction(transaction_id, seller_asking_price, buyer_asking_price, got_property, sell_price,
offer_date, sell_date, property_id, buyer_realtor_relation_id, seller_realtor_relation_id) VALUES
(1,5200,4770,1,4800,'2024-12-08','2024-12-30',1, 3, 1),
(2,875000,625000,1,675000,'2025-02-22','2025-02-28',2, 12, 2),
(3, 1700, 1600, 1, 1650, '2024-11-18', '2025-01-01', 3, 1, 3),
(4, 4850,4850,1,4850,'2022-05-11','2022-07-22',4, 21, 4),
(5,1175000,650000,0,1250000,'2025-02-07','2025-02-23', 6, 12, 6),
(6,1175000,1250000,1,1250000,'2025-02-12','2025-02-23', 6, 4, 6),
(7,5200,5300,1,5250,'2024-08-27','2024-09-11',7, 17, 7),
(8,612500,570000,1,575000,'2025-02-01','2025-02-17',14, 18, 14),
(9,3500,3200,1,3475,'2024-07-29','2024-08-29',15, 9, 1),
(10,765000,740000,1,750000,'2025-09-20','2025-09-23',10, 19, 10),
(11,2575,2420,1,2500,'2025-10-22','2025-10-23',12, 20, 12),
(12,10000000,6500000,1,7650000,'2025-01-24','2025-02-25',19, 21, 15),
(13, 3000, 2925, 1, 3000, '2024-08-12', '2024-08-30',20, 14, 18),
(14, 4200, 3950, 1, 4100, '2024-09-15', '2024-10-05', 9, 22, 9),
(15, 550000, 525000, 1, 540000, '2025-03-10', '2025-05-19', 24, 29, 24),
(16, 3800, 3600, 1, 3725, '2024-12-01', '2024-12-20', 23, 27, 20),
(17, 875000, 850000, 1, 862500, '2025-01-15', '2025-02-10', 22, 29, 22),
(18, 4950, 4800, 1, 4900, '2024-10-18', '2024-11-12', 25, 30, 23);




