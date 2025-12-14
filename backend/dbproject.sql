DROP DATABASE IF EXISTS agency_db;
CREATE DATABASE agency_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE agency_db;

-- ===============================
-- BASE TABLES
-- ===============================

CREATE TABLE personnel (
    personnel_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    personnel_type VARCHAR(50),
    contract_hire_date DATE,
    contract_expiration_date DATE
);

CREATE TABLE performer (
    personnel_id INTEGER PRIMARY KEY,
    performance_type VARCHAR(50),
    agency VARCHAR(50),
    CONSTRAINT fk_performer_personnel
        FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id)
);

CREATE TABLE partner_personnel (
    partner_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    service_type VARCHAR(50),
    personnel_id INTEGER,
    contact_hire_date DATE,
    contact_expiration_date DATE,
    contract_amount DECIMAL(10,2),
    contact_info TEXT,
    CONSTRAINT fk_partner_personnel
        FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id) ON DELETE SET NULL
);

-- ===============================
-- PRODUCTION
-- ===============================

CREATE TABLE production (
    production_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    production_type VARCHAR(50),
    contract_hire_date DATE,
    contract_expiration_date DATE,
    partner_id INTEGER,
    CONSTRAINT fk_production_partner
        FOREIGN KEY (partner_id) REFERENCES partner_personnel(partner_id) ON DELETE SET NULL
);

CREATE TABLE generalproduction (
    production_id INTEGER PRIMARY KEY,
    genre VARCHAR(50),
    plan_release_quarter INTEGER,
    plan_release_year INTEGER,
    CONSTRAINT fk_generalproduction_production
        FOREIGN KEY (production_id) REFERENCES production(production_id)
);

CREATE TABLE eventproduction (
    production_id INTEGER PRIMARY KEY,
    event_type VARCHAR(50),
    location VARCHAR(50),
    audience_capacity INTEGER,
    CONSTRAINT fk_eventproduction_production
        FOREIGN KEY (production_id) REFERENCES production(production_id)
);

CREATE TABLE productionexpense (
    expense_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    production_id INTEGER,
    expense_type VARCHAR(50),
    amount DECIMAL(10,2),
    expense_date DATE,
    description TEXT,
    CONSTRAINT fk_productionexpense_production
        FOREIGN KEY (production_id) REFERENCES production(production_id) ON DELETE CASCADE
);

CREATE TABLE personnelassignment (
    personnel_id INTEGER,
    production_id INTEGER,
    role_title VARCHAR(50),
    PRIMARY KEY (personnel_id, production_id),
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id),
    FOREIGN KEY (production_id) REFERENCES production(production_id)
);


CREATE TABLE productionschedule (
    prod_schedule_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    production_id INTEGER NOT NULL,
    personnel_id INTEGER NOT NULL,
    start_dt DATETIME,
    end_dt DATETIME,
    taskname VARCHAR(50),
    location VARCHAR(50),
    FOREIGN KEY (production_id) REFERENCES production(production_id) ON DELETE CASCADE,
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id) ON DELETE CASCADE
);


CREATE TABLE rentalplace (
    place_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    type VARCHAR(50),
    capacity INTEGER,
    contact_info TEXT
);

CREATE TABLE rentalusage (
    usage_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    production_id INTEGER NOT NULL,
    place_id INTEGER NOT NULL,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (production_id) REFERENCES production(production_id) ON DELETE CASCADE,
    FOREIGN KEY (place_id) REFERENCES rentalplace(place_id) ON DELETE CASCADE
);

CREATE TABLE rentalpayment (
    payment_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    usage_id INTEGER NOT NULL,
    daily_rate DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (usage_id) REFERENCES rentalusage(usage_id) ON DELETE CASCADE
);

-- ===============================
-- SAMPLE DATA
-- ===============================

INSERT INTO personnel VALUES
(1,'Alice Kim','alice@example.com','0811111111','Actor','2024-01-10','2026-01-10'),
(2,'Ben Park','ben@example.com','0822222222','Director','2023-05-05','2025-05-05'),
(3,'Cara Lim','cara@example.com','0833333333','Producer','2022-03-01','2024-03-01'),
(4,'David Wong','david@example.com','0844444444','Crew','2024-02-15','2027-02-15'),
(5,'Ellie Tran','ellie@example.com','0855555555','Actor','2023-12-01','2026-12-01');

INSERT INTO performer VALUES
(1,'Singer','StarMagic'),
(2,'Actor','VisionTalent'),
(3,'Dancer','MoveCrew'),
(4,'Guitarist','StringHouse'),
(5,'Host','BrightMedia');

INSERT INTO partner_personnel VALUES
(1,'StudioX','Equipment',3,'2023-01-01','2024-12-31',50000,'contact@studiox.com'),
(2,'LightPro','Lighting',4,'2023-02-10','2025-02-10',35000,'info@lightpro.com'),
(3,'StageSet','Stage Design',5,'2024-03-01','2026-03-01',80000,'stage@stageset.com'),
(4,'TalentHub','Casting',1,'2023-07-01','2025-07-01',45000,'talent@hub.com'),
(5,'CrewPlus','Crew',2,'2024-01-20','2026-01-20',60000,'support@crewplus.com');

INSERT INTO production VALUES
(1,'Moonlight','General','2024-01-10','2025-01-10',1),
(2,'Skyfall Event','Event','2024-02-15','2025-02-15',2),
(3,'River Story','General','2023-11-01','2024-11-01',3),
(4,'Neon Concert','Event','2024-04-01','2025-04-01',4),
(5,'Legends','General','2024-05-20','2026-05-20',5);

INSERT INTO generalproduction VALUES
(1,'Drama',1,2025),
(3,'Music',3,2024),
(5,'Fantasy',4,2026);

INSERT INTO eventproduction VALUES
(2,'Concert','Bangkok Arena',5000),
(4,'Festival','Central Park',3000);

INSERT INTO productionexpense VALUES
(1,1,'Costume',12000,'2024-02-01','Costume prep'),
(2,2,'Lighting',8000,'2024-02-20','Lighting setup'),
(3,3,'Props',5000,'2024-01-10','Props'),
(4,4,'Sound',9000,'2024-04-12','Sound'),
(5,5,'Promotion',15000,'2024-05-30','Ads');

INSERT INTO personnelassignment VALUES
(1,1,'Lead Actor'),
(2,2,'Director'),
(3,3,'Producer'),
(4,4,'Crew'),
(5,5,'Supporting Actor');

INSERT INTO productionschedule VALUES
(1,1,1,'2024-02-10 09:00','2024-02-10 12:00','Shoot','Studio 1'),
(2,2,2,'2024-03-01 10:00','2024-03-01 15:00','Rehearsal','Hall'),
(3,3,3,'2024-01-20 08:00','2024-01-20 11:00','Reading','Room A'),
(4,4,4,'2024-04-15 14:00','2024-04-15 18:00','Setup','Arena'),
(5,5,5,'2024-05-22 09:00','2024-05-22 12:00','Shoot','Beach');

INSERT INTO rentalplace VALUES
(1,'Studio A','123 Main Rd','Studio',100,'0912345678'),
(2,'Arena X','456 Sport Rd','Arena',5000,'0888888888'),
(3,'Hall B','789 Center St','Hall',800,'0877777777');

INSERT INTO rentalusage VALUES
(1,1,1,'2024-02-10 08:00','2024-02-10 18:00'),
(2,2,2,'2024-03-01 12:00','2024-03-01 22:00'),
(3,3,3,'2024-01-20 09:00','2024-01-20 17:00');

INSERT INTO rentalpayment VALUES
(1,1,5000,5000,'2024-02-11'),
(2,2,8000,8000,'2024-03-02'),
(3,3,4000,4000,'2024-01-21');

-- ===============================
-- 15 QUERIES (DATETIME SAFE)
-- ===============================

-- 1) List all personnel who are directors / costumers / makeup / actors
SELECT * FROM personnel WHERE personnel_type IN ('Director','Costumer','Makeup','Actor');

-- 2) Find actors/crew that are free between two datetimes
SELECT p.*
FROM personnel p
WHERE p.personnel_type IN ('Actor','Crew')
AND NOT EXISTS (
    SELECT 1 FROM productionschedule s
    WHERE s.personnel_id = p.personnel_id
    AND s.start_dt < '2024-02-10 12:00'
    AND s.end_dt   > '2024-02-10 09:00'
);

-- 3) Find available rental places for a given datetime range
SELECT * FROM rentalplace rp
WHERE NOT EXISTS (
    SELECT 1 FROM rentalusage ru
    WHERE ru.place_id = rp.place_id
    AND ru.start_time < '2024-02-10 12:00'
    AND ru.end_time   > '2024-02-10 09:00'
);

-- 4) Check amount of activity types between two datetimes (by date)
SELECT taskname, COUNT(*) FROM productionschedule
WHERE start_dt BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY taskname;

-- 5) Top 3 actors/actresses with most production projects
SELECT p.name, COUNT(*) total
FROM personnel p
JOIN personnelassignment pa ON p.personnel_id = pa.personnel_id
WHERE p.personnel_type IN ('Actor','Actress')
GROUP BY p.name
ORDER BY total DESC
LIMIT 3;

-- 6) 5 actors with the least jobs (including those with 0)
SELECT p.name, COUNT(pa.production_id) total
FROM personnel p
LEFT JOIN personnelassignment pa ON p.personnel_id = pa.personnel_id
WHERE p.personnel_type IN ('Actor','Actress')
GROUP BY p.name
ORDER BY total
LIMIT 5;

-- 7) List all personnel and their assigned productions
SELECT p.name, pr.title FROM personnel p
LEFT JOIN personnelassignment pa ON p.personnel_id = pa.personnel_id
LEFT JOIN production pr ON pa.production_id = pr.production_id;

-- 8) Show all productions with their type and partner name
SELECT pr.title, pr.production_type, pp.name
FROM production pr
LEFT JOIN partner_personnel pp ON pr.partner_id = pp.partner_id;

-- 9) Display the schedule of all personnel for a specific datetime (date part)
SELECT * FROM productionschedule
WHERE DATE(start_dt) = '2024-02-10';

-- 10) List rental places currently in use at a given datetime
SELECT rp.name FROM rentalplace rp
JOIN rentalusage ru ON rp.place_id = ru.place_id
WHERE '2024-02-10 10:00' BETWEEN ru.start_time AND ru.end_time;

-- 11) Show production expenses grouped by production
SELECT pr.title, SUM(pe.amount)
FROM production pr
LEFT JOIN productionexpense pe ON pr.production_id = pe.production_id
GROUP BY pr.title;

-- 12) List all performers and their performance types
SELECT p.name, pf.performance_type FROM performer pf
JOIN personnel p ON pf.personnel_id = p.personnel_id;

-- 13) Find all partners and which personnel they are contracted with
SELECT pp.name partner, p.name personnel
FROM partner_personnel pp
LEFT JOIN personnel p ON pp.personnel_id = p.personnel_id;

-- 14) Get upcoming production schedules (from today onwards)
SELECT * FROM productionschedule
WHERE start_dt >= NOW();

-- 15) List music productions with performer and planned release info
-- (Assuming generalproduction.genre = 'Music'
--  and performers are assigned via personnelassignment.)
SELECT pr.title, p.name performer
FROM production pr
JOIN generalproduction gp ON pr.production_id = gp.production_id
JOIN personnelassignment pa ON pr.production_id = pa.production_id
JOIN personnel p ON pa.personnel_id = p.personnel_id
WHERE gp.genre = 'Music';
