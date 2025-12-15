DROP DATABASE IF EXISTS ProjectDB;
CREATE DATABASE ProjectDB;
USE ProjectDB;

-- ===============================
-- BASE TABLES
-- ===============================

CREATE TABLE personnel (
    personnel_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(50),
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
    partner_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    service_type VARCHAR(50),
    personnel_id INTEGER,
    contact_hire_date DATE,
    contact_expiration_date DATE,
    contract_amount NUMERIC,
    contact_info TEXT,
    CONSTRAINT fk_partner_personnel
        FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id)
);

-- ===============================
-- PRODUCTION
-- ===============================

CREATE TABLE production (
    production_id INTEGER PRIMARY KEY,
    title VARCHAR(50),
    production_type VARCHAR(50),
    contract_hire_date DATE,
    contract_expiration_date DATE,
    partner_id INTEGER,
    CONSTRAINT fk_production_partner
        FOREIGN KEY (partner_id) REFERENCES partner_personnel(partner_id)
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
    expense_id INTEGER PRIMARY KEY,
    production_id INTEGER,
    expense_type VARCHAR(50),
    amount NUMERIC,
    expense_date DATE,
    description TEXT,
    CONSTRAINT fk_productionexpense_production
        FOREIGN KEY (production_id) REFERENCES production(production_id)
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
    prod_schedule_id INTEGER PRIMARY KEY,
    production_id INTEGER,
    personnel_id INTEGER,
    start_dt DATETIME,
    end_dt DATETIME,
    taskname VARCHAR(50),
    location VARCHAR(50),
    FOREIGN KEY (production_id) REFERENCES production(production_id),
    FOREIGN KEY (personnel_id) REFERENCES personnel(personnel_id)
);


CREATE TABLE rentalplace (
    place_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    address TEXT,
    type VARCHAR(50),
    capacity INTEGER,
    contact_info TEXT
);

CREATE TABLE rentalusage (
    usage_id INTEGER PRIMARY KEY,
    production_id INTEGER,
    place_id INTEGER,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (production_id) REFERENCES production(production_id),
    FOREIGN KEY (place_id) REFERENCES rentalplace(place_id)
);

CREATE TABLE rentalpayment (
    payment_id INTEGER PRIMARY KEY,
    usage_id INTEGER,
    daily_rate NUMERIC,
    total_cost NUMERIC,
    payment_date DATE,
    FOREIGN KEY (usage_id) REFERENCES rentalusage(usage_id)
);

-- ===============================
-- SAMPLE DATA
-- ===============================

-- INSERT INTO personnel VALUES
-- (1,'Alice Kim','alice@example.com','0811111111','Actor','2024-01-10','2026-01-10'),
-- (2,'Ben Park','ben@example.com','0822222222','Director','2023-05-05','2025-05-05'),
-- (3,'Cara Lim','cara@example.com','0833333333','Producer','2022-03-01','2024-03-01'),
-- (4,'David Wong','david@example.com','0844444444','Crew','2024-02-15','2027-02-15'),
-- (5,'Ellie Tran','ellie@example.com','0855555555','Actor','2023-12-01','2026-12-01');

-- INSERT INTO performer VALUES
-- (1,'Singer','StarMagic'),
-- (2,'Actor','VisionTalent'),
-- (3,'Dancer','MoveCrew'),
-- (4,'Guitarist','StringHouse'),
-- (5,'Host','BrightMedia');

-- INSERT INTO partner_personnel VALUES
-- (1,'StudioX','Equipment',3,'2023-01-01','2024-12-31',50000,'contact@studiox.com'),
-- (2,'LightPro','Lighting',4,'2023-02-10','2025-02-10',35000,'info@lightpro.com'),
-- (3,'StageSet','Stage Design',5,'2024-03-01','2026-03-01',80000,'stage@stageset.com'),
-- (4,'TalentHub','Casting',1,'2023-07-01','2025-07-01',45000,'talent@hub.com'),
-- (5,'CrewPlus','Crew',2,'2024-01-20','2026-01-20',60000,'support@crewplus.com');

-- INSERT INTO production VALUES
-- (1,'Moonlight','General','2024-01-10','2025-01-10',1),
-- (2,'Skyfall Event','Event','2024-02-15','2025-02-15',2),
-- (3,'River Story','General','2023-11-01','2024-11-01',3),
-- (4,'Neon Concert','Event','2024-04-01','2025-04-01',4),
-- (5,'Legends','General','2024-05-20','2026-05-20',5);

-- INSERT INTO generalproduction VALUES
-- (1,'Drama',1,2025),
-- (3,'Music',3,2024),
-- (5,'Fantasy',4,2026);

-- INSERT INTO eventproduction VALUES
-- (2,'Concert','Bangkok Arena',5000),
-- (4,'Festival','Central Park',3000);

-- INSERT INTO productionexpense VALUES
-- (1,1,'Costume',12000,'2024-02-01','Costume prep'),
-- (2,2,'Lighting',8000,'2024-02-20','Lighting setup'),
-- (3,3,'Props',5000,'2024-01-10','Props'),
-- (4,4,'Sound',9000,'2024-04-12','Sound'),
-- (5,5,'Promotion',15000,'2024-05-30','Ads');

-- INSERT INTO personnelassignment VALUES
-- (1,1,'Lead Actor'),
-- (2,2,'Director'),
-- (3,3,'Producer'),
-- (4,4,'Crew'),
-- (5,5,'Supporting Actor');

-- INSERT INTO productionschedule VALUES
-- (1,1,1,'2024-02-10 09:00','2024-02-10 12:00','Shoot','Studio 1'),
-- (2,2,2,'2024-03-01 10:00','2024-03-01 15:00','Rehearsal','Hall'),
-- (3,3,3,'2024-01-20 08:00','2024-01-20 11:00','Reading','Room A'),
-- (4,4,4,'2024-04-15 14:00','2024-04-15 18:00','Setup','Arena'),
-- (5,5,5,'2024-05-22 09:00','2024-05-22 12:00','Shoot','Beach');

-- INSERT INTO rentalplace VALUES
-- (1,'Studio A','123 Main Rd','Studio',100,'0912345678'),
-- (2,'Arena X','456 Sport Rd','Arena',5000,'0888888888'),
-- (3,'Hall B','789 Center St','Hall',800,'0877777777');

-- INSERT INTO rentalusage VALUES
-- (1,1,1,'2024-02-10 08:00','2024-02-10 18:00'),
-- (2,2,2,'2024-03-01 12:00','2024-03-01 22:00'),
-- (3,3,3,'2024-01-20 09:00','2024-01-20 17:00');

-- INSERT INTO rentalpayment VALUES
-- (1,1,5000,5000,'2024-02-11'),
-- (2,2,8000,8000,'2024-03-02'),
-- (3,3,4000,4000,'2024-01-21');
-- =====================================================
-- PERSONNEL (25 rows total)
-- =====================================================
-- =============================================
-- 1. PERSONNEL (IDs 1-50)
-- Expanded types: Actor, Actress, Director, Costumer, Makeup, Producer, Manager
-- =============================================

INSERT INTO personnel (personnel_id, name, email, phone, personnel_type, contract_hire_date, contract_expiration_date) VALUES 
-- --- ORIGINAL BATCH (1-20) ---
(1, 'Leonardo DiC.', 'leo@hollywood.com', '555-0101', 'Actor', '2021-01-01', '2026-01-01'),
(2, 'Meryl Str.', 'meryl@acting.com', '555-0102', 'Actor', '2021-05-01', '2025-05-01'),
(3, 'Tom Han.', 'tom@castaway.com', '555-0103', 'Actor', '2022-01-01', '2027-01-01'),
(4, 'Scarlett Jo.', 'scarlett@avengers.com', '555-0104', 'Actress', '2023-01-01', '2026-01-01'),
(5, 'Brad P.', 'brad@fightclub.com', '555-0105', 'Actor', '2021-06-01', '2024-06-01'),
(6, 'Jennifer Law.', 'jen@mockingjay.com', '555-0106', 'Actress', '2023-03-01', '2025-03-01'),
(7, 'Unemployed Actor', 'nopwork@actor.com', '555-0107', 'Actor', '2024-01-01', '2025-01-01'),
(8, 'Newbie Actor', 'new@actor.com', '555-0108', 'Actor', '2024-02-01', '2025-02-01'),
(9, 'Sarah Makeup', 'sarah@glam.com', '555-0201', 'Makeup', '2022-01-01', '2026-01-01'),
(10, 'Mike Brush', 'mike@fx.com', '555-0202', 'Makeup', '2022-05-01', '2025-05-01'),
(11, 'Coco Chanel', 'coco@style.com', '555-0203', 'Costumer', '2021-01-01', '2027-01-01'),
(12, 'Ralph Lauren', 'ralph@polo.com', '555-0204', 'Costumer', '2023-01-01', '2026-01-01'),
(13, 'Steven Spiel.', 'stevie@movies.com', '555-0301', 'Director', '2021-01-01', '2027-01-01'),
(14, 'Christopher No.', 'chris@inception.com', '555-0302', 'Director', '2022-01-01', '2026-01-01'),
(15, 'Kevin Fei.', 'kevin@marvel.com', '555-0303', 'Producer', '2021-01-01', '2027-01-01'),
(16, 'Jerry Bru.', 'jerry@boom.com', '555-0304', 'Producer', '2023-01-01', '2025-01-01'),
(17, 'Alice Admin', 'alice@catering.com', '555-0401', 'Manager', '2022-01-01', '2025-01-01'),
(18, 'Bob Logistics', 'bob@trucks.com', '555-0402', 'Manager', '2022-03-01', '2026-03-01'),
(19, 'Charlie Light', 'charlie@sparks.com', '555-0403', 'Manager', '2023-01-01', '2027-01-01'),
(20, 'Diana Sound', 'diana@audio.com', '555-0404', 'Manager', '2023-05-01', '2024-12-31'),

-- --- NEW BATCH (21-50) ---
-- More Actors/Actresses for "Top 3" and "Least Jobs" queries
(21, 'Robert Den.', 'bob@taxi.com', '555-0501', 'Actor', '2021-01-01', '2025-01-01'),
(22, 'Al Pac.', 'al@godfather.com', '555-0502', 'Actor', '2021-02-01', '2025-02-01'),
(23, 'Julia Rob.', 'julia@pretty.com', '555-0503', 'Actor', '2022-01-01', '2026-01-01'),
(24, 'Emma Sto.', 'emma@lalaland.com', '555-0504', 'Actor', '2023-01-01', '2027-01-01'),
(25, 'Chris Hem.', 'chris@thor.com', '555-0505', 'Actor', '2022-05-01', '2025-05-01'),
(26, 'Ryan Gos.', 'ryan@ken.com', '555-0506', 'Actor', '2023-01-01', '2026-01-01'),
(27, 'Zendaya C.', 'zen@dune.com', '555-0507', 'Actor', '2023-06-01', '2027-01-01'),
(28, 'Timothee C.', 'tim@dune.com', '555-0508', 'Actor', '2023-06-01', '2027-01-01'),
(29, 'Viola D.', 'viola@fences.com', '555-0509', 'Actor', '2021-08-01', '2025-08-01'),
(30, 'Denzel W.', 'denzel@equalizer.com', '555-0510', 'Actor', '2021-09-01', '2025-09-01'),
-- Actors with NO jobs (for Query 6)
(31, 'Silent Extra', 'silent@extra.com', '555-0601', 'Actor', '2024-01-01', '2024-12-31'),
(32, 'Background B', 'bg@extra.com', '555-0602', 'Actor', '2024-01-01', '2024-12-31'),
-- More Crew
(33, 'Pat Makeup', 'pat@face.com', '555-0701', 'Makeup', '2023-01-01', '2026-01-01'),
(34, 'Alex Costume', 'alex@sew.com', '555-0702', 'Costumer', '2023-01-01', '2026-01-01'),
(35, 'Sam Director', 'sam@cut.com', '555-0703', 'Director', '2024-01-01', '2027-01-01'),
(36, 'Greta G.', 'greta@barbie.com', '555-0704', 'Director', '2023-01-01', '2026-01-01'),
(37, 'Quentin T.', 'quentin@pulp.com', '555-0705', 'Director', '2021-01-01', '2025-01-01'),
(38, 'Martin S.', 'marty@irishman.com', '555-0706', 'Producer', '2021-01-01', '2025-01-01'),
-- Partner Contacts
(39, 'Eve Pyrotechnics', 'eve@boom.com', '555-0801', 'Manager', '2024-01-01', '2027-01-01'),
(40, 'Frank Security', 'frank@guard.com', '555-0802', 'Manager', '2023-01-01', '2025-01-01');

-- 1.2 PERFORMERS (Subclass of Personnel)
INSERT INTO performer (personnel_id, performance_type, agency) VALUES 
(1, 'Dramatic Actor', 'CAA'), (2, 'Method Actor', 'WME'), (3, 'Comedic Actor', 'UTA'),
(4, 'Action Star', 'CAA'), (5, 'Stunt Performer', 'Stunt Guild'), (6, 'Voice Actor', 'Voice Agency'),
(21, 'Method Actor', 'CAA'), (22, 'Method Actor', 'ICM'), (23, 'Lead Actress', 'WME'),
(24, 'Musical Performer', 'UTA'), (25, 'Action Star', 'CAA'), (26, 'Lead Actor', 'WME'),
(27, 'Model/Actress', 'IMG'), (28, 'Dramatic Actor', 'UTA'), (29, 'Stage Actress', 'Juilliard'),
(30, 'Dramatic Actor', 'WME');

-- =============================================
-- 2. PARTNERS & PLACES
-- =============================================

INSERT INTO rentalplace (place_id, name, address, type, capacity, contact_info) VALUES 
(1, 'Grand Theater', '100 Broadway', 'Indoor', 2000, 'mgr@grand.com'),
(2, 'City Park Amphitheater', '200 Park Ave', 'Outdoor', 5000, 'parks@city.gov'),
(3, 'Studio 54', '54 Studio Ln', 'Studio', 100, 'booking@54.com'),
(4, 'Warehouse District', '88 Industrial', 'Location', 50, 'owner@warehouse.com'),
(5, 'Concert Hall', '1 Music Way', 'Indoor', 1500, 'info@hall.com'),
-- NEW PLACES
(6, 'Royal Opera House', '50 King St', 'Theater', 2500, 'royal@opera.com'),
(7, 'Downtown Arena', '10 Center Blvd', 'Arena', 15000, 'admin@arena.com'),
(8, 'Sunset Ranch', '500 Desert Rd', 'Outdoor', 200, 'ranch@films.com'),
(9, 'Underground Club', '9 Basement St', 'Club', 300, 'club@noise.com'),
(10, 'Convention Center', '1 Expo Dr', 'Hall', 10000, 'expo@city.com');

INSERT INTO partner_personnel (partner_id, name, service_type, personnel_id, contact_hire_date, contact_expiration_date, contract_amount, contact_info) VALUES 
(100, 'Gourmet Catering', 'Food', 17, '2023-01-01', '2026-12-31', 50000.00, 'Kitchen HQ'),
(101, 'Fast Logistics', 'Transport', 18, '2023-01-01', '2026-12-31', 75000.00, 'Fleet HQ'),
(102, 'Bright Lights Inc', 'Lighting', 19, '2024-01-01', '2026-01-01', 30000.00, 'Warehouse A'),
(103, 'Crystal Clear Audio', 'Sound', 20, '2023-06-01', '2027-06-01', 25000.00, 'Studio B'),
-- NEW PARTNERS
(104, 'Firestar Pyros', 'Special FX', 39, '2024-01-01', '2026-01-01', 40000.00, 'Safe Zone 1'),
(105, 'SafeGuard Security', 'Security', 40, '2023-01-01', '2025-01-01', 60000.00, 'Post 1'),
(106, 'Costume Kingdom', 'Wardrobe', 11, '2022-01-01', '2026-01-01', 20000.00, 'Sewing Room'),
(107, 'Orchestra Union', 'Musicians', 20, '2024-01-01', '2025-01-01', 100000.00, 'Union Hall'),
(108, 'Set Builders Ltd', 'Construction', 18, '2023-01-01', '2025-01-01', 90000.00, 'Workshop');

-- =============================================
-- 3. PRODUCTIONS (IDs 10-40)
-- =============================================

INSERT INTO production (production_id, title, production_type, contract_hire_date, contract_expiration_date, partner_id) VALUES 
(10, 'The Great Movie', 'General', '2023-01-01', '2023-12-31', 100),
(11, 'Summer Music Fest', 'Event', '2024-02-01', '2024-02-28', 103),
(12, 'Hamlet Reborn', 'General', '2024-01-01', '2024-06-01', 102),
(13, 'Sci-Fi Epic', 'General', '2025-01-01', '2026-01-01', 101),
(14, 'Indie Drama', 'General', '2022-01-01', '2022-06-01', 100),
(15, 'Rock Concert 2024', 'Event', '2024-02-10', '2024-02-10', 103),
(16, 'Symphony Night', 'Event', '2024-03-01', '2024-03-02', 107),
(17, 'Future Tech Doc', 'General', '2026-05-01', '2027-01-01', 101),
(18, 'Comedy Special', 'General', '2023-11-01', '2024-01-01', 103),
(19, 'Mystery Series', 'General', '2024-08-01', '2025-08-01', 100),
-- NEW PRODUCTIONS
(20, 'Action Blast 4', 'General', '2024-05-01', '2024-12-01', 104),
(21, 'Romantic Comedy', 'General', '2023-02-01', '2023-08-01', 106),
(22, 'Historical War', 'General', '2021-01-01', '2022-01-01', 108),
(23, 'Jazz Festival', 'Event', '2024-06-15', '2024-06-16', 103),
(24, 'Magic Show', 'Event', '2024-12-01', '2024-12-31', 102),
(25, 'Super Hero Team', 'General', '2025-03-01', '2026-03-01', 104),
(26, 'Space Opera', 'General', '2026-01-01', '2027-01-01', 101),
(27, 'Opera Gala', 'Event', '2024-11-01', '2024-11-02', 107),
(28, 'Charity Ball', 'Event', '2024-02-10', '2024-02-10', 100),
(29, 'Fashion Week', 'Event', '2024-09-01', '2024-09-07', 102),
(30, 'Documentary: Nature', 'General', '2021-03-01', '2021-12-01', 101),
(31, 'Silent Film Remake', 'General', '2022-04-01', '2022-09-01', 106),
(32, 'Pop Star Tour', 'Event', '2025-05-01', '2025-08-01', 105),
(33, 'Horror House', 'General', '2024-10-01', '2024-11-01', 108),
(34, 'Broadway Musical', 'Event', '2024-01-01', '2025-01-01', 106),
(35, 'Standup Tour', 'Event', '2023-06-01', '2023-07-01', 103),
(36, 'Cooking Show', 'General', '2022-01-01', '2024-01-01', 100),
(37, 'Tech Expo', 'Event', '2024-05-10', '2024-05-12', 102),
(38, 'Western Duel', 'General', '2021-05-01', '2021-08-01', 108),
(39, 'Car Chase Movie', 'General', '2025-06-01', '2025-12-01', 104),
(40, 'Teen Drama', 'General', '2023-09-01', '2024-05-01', 100);

-- 3.1 SUB-TABLES
INSERT INTO generalproduction (production_id, genre, plan_release_quarter, plan_release_year) VALUES 
(10, 'Drama', 4, 2023), (12, 'Theater', 2, 2024), (13, 'Sci-Fi', 2, 2026),
(14, 'Drama', 3, 2022), (17, 'Documentary', 1, 2027), (18, 'Comedy', 1, 2024),
(19, 'Music', 4, 2025), (20, 'Action', 2, 2025), (21, 'Romance', 4, 2023),
(22, 'History', 1, 2023), (25, 'Action', 3, 2026), (26, 'Sci-Fi', 2, 2027),
(30, 'Documentary', 4, 2022), (31, 'Art House', 1, 2023), (33, 'Horror', 4, 2025),
(36, 'Reality', 1, 2024), (38, 'Western', 3, 2022), (39, 'Action', 2, 2026),
(40, 'Music', 2, 2024);

INSERT INTO eventproduction (production_id, event_type, location, audience_capacity) VALUES 
(11, 'Festival', 'Park', 5000), (15, 'Concert', 'Stadium', 20000), (16, 'Orchestra', 'Hall', 1500),
(23, 'Festival', 'Downtown', 3000), (24, 'Performance', 'Theater', 800),
(27, 'Gala', 'Opera House', 2500), (28, 'Gala', 'Hotel Ballroom', 500),
(29, 'Runway', 'Convention Ctr', 1000), (32, 'Concert', 'Arena', 15000),
(34, 'Musical', 'Broadway', 1200), (35, 'Comedy', 'Club', 200),
(37, 'Expo', 'Hall', 5000);

-- =============================================
-- 4. ASSIGNMENTS
-- High volume of assignments to ensure Query 5 (Top 3) works well
-- =============================================

INSERT INTO personnelassignment (personnel_id, production_id, role_title) VALUES 
-- TOP ACTORS (Aiming for IDs 24, 25, 27 to be top)
(24, 20, 'Lead'), (24, 21, 'Lead'), (24, 34, 'Singer'), (24, 25, 'Hero'), (24, 40, 'Cameo'), -- Emma Stone: 5 jobs
(25, 20, 'Villain'), (25, 25, 'Hero'), (25, 39, 'Driver'), (25, 22, 'Soldier'), (25, 13, 'Pilot'), -- Chris Hem: 5 jobs
(27, 26, 'Alien'), (27, 29, 'Model'), (27, 40, 'Student'), (27, 13, 'Princess'), -- Zendaya: 4 jobs

-- Moderate Actors
(1, 10, 'Lead'), (1, 12, 'Lead'), (1, 13, 'Supporting'), 
(2, 10, 'Lead'), (2, 14, 'Lead'), (2, 21, 'Mother'),
(3, 13, 'Lead'), (3, 17, 'Narrator'),
(4, 19, 'Lead'), (4, 20, 'Spy'),
(21, 10, 'Mobster'), (21, 38, 'Sheriff'),
(22, 10, 'Godfather'), (22, 12, 'King'),
(23, 21, 'Lead'), (23, 28, 'Host'),
(26, 21, 'Lead'), (26, 39, 'Racer'),
(28, 26, 'Hero'), (28, 14, 'Son'),
(29, 22, 'Wife'), (29, 30, 'Voice'),
(30, 20, 'Cop'), (30, 31, 'Silent Star'),

-- Crew Assignments
(35, 20, 'Director'), (35, 25, 'Director'),
(36, 21, 'Director'), (36, 31, 'Director'),
(37, 22, 'Director'), (37, 39, 'Director'),
(9, 10, 'Makeup'), (9, 20, 'Makeup'), (9, 25, 'Makeup'),
(33, 21, 'Makeup'), (33, 24, 'Makeup'),
(11, 21, 'Costume'), (11, 29, 'Costume'),
(34, 22, 'Costume'), (34, 26, 'Costume'),
(15, 25, 'Producer'), (16, 20, 'Producer'), (38, 22, 'Producer');

-- =============================================
-- 5. SCHEDULES (Expanded)
-- Target Date for Logic: 2024-02-10
-- =============================================

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES 
-- 5.1 BUSY on 2024-02-10 (Query 2 check: needs to find people FREE, so we make some BUSY)
(1, 11, 1, '2024-02-10 08:00:00', '2024-02-10 13:00:00', 'Rehearsal', 'Studio A'), 
(100, 28, 23, '2024-02-10 09:00:00', '2024-02-10 14:00:00', 'Gala Prep', 'Ballroom'),
(101, 15, 24, '2024-02-10 10:00:00', '2024-02-10 22:00:00', 'Concert', 'Stadium'),
(102, 15, 33, '2024-02-10 09:00:00', '2024-02-10 18:00:00', 'Makeup', 'Tent'),

-- 5.2 FREE on 2024-02-10 (Start/End don't overlap 09:00-12:00)
(2, 11, 2, '2024-02-10 14:00:00', '2024-02-10 18:00:00', 'Filming', 'Studio B'),
(3, 11, 3, '2024-02-10 06:00:00', '2024-02-10 08:30:00', 'Makeup Call', 'Trailer 1'),

-- 5.3 General 2024 Data (Query 4 & 9)
(4, 12, 1, '2024-01-15 09:00:00', '2024-01-15 17:00:00', 'Filming', 'Set 1'),
(5, 12, 4, '2024-03-01 09:00:00', '2024-03-01 17:00:00', 'Filming', 'Set 1'),
(6, 12, 9, '2024-04-10 09:00:00', '2024-04-10 17:00:00', 'Makeup', 'Trailer'),
(7, 19, 1, '2024-09-01 10:00:00', '2024-09-01 14:00:00', 'Promo', 'Office'),
(103, 34, 24, '2024-05-15 18:00:00', '2024-05-15 22:00:00', 'Show', 'Broadway'),
(104, 34, 24, '2024-05-16 18:00:00', '2024-05-16 22:00:00', 'Show', 'Broadway'),
(105, 20, 25, '2024-06-01 06:00:00', '2024-06-01 18:00:00', 'Stunt Scene', 'Location X'),
(106, 20, 35, '2024-06-01 06:00:00', '2024-06-01 18:00:00', 'Directing', 'Location X'),
(107, 23, 20, '2024-06-15 10:00:00', '2024-06-15 22:00:00', 'Sound Check', 'Downtown'),

-- 5.4 Future Data 2025+ (Query 14)
(8, 13, 1, '2026-06-01 09:00:00', '2026-06-01 18:00:00', 'Future Shoot', 'Space Set'),
(9, 17, 3, '2027-01-10 10:00:00', '2027-01-10 12:00:00', 'Voiceover', 'Booth'),
(10, 19, 4, '2025-12-01 09:00:00', '2025-12-01 17:00:00', 'Wrap Party', 'Hotel'),
(108, 25, 25, '2025-04-01 08:00:00', '2025-04-01 18:00:00', 'Blue Screen', 'Studio 5'),
(109, 26, 27, '2026-02-01 09:00:00', '2026-02-01 15:00:00', 'Fitting', 'Wardrobe'),
(110, 26, 28, '2026-03-01 08:00:00', '2026-03-01 20:00:00', 'Desert Scene', 'Dunes');

-- =============================================
-- 6. RENTAL USAGE
-- Target Date for Logic: 2024-02-10 10:00
-- =============================================

INSERT INTO rentalusage (usage_id, production_id, place_id, start_time, end_time) VALUES 
-- BUSY on Feb 10 2024
(100, 11, 1, '2024-02-10 08:00:00', '2024-02-10 20:00:00'),
(200, 28, 5, '2024-02-10 08:00:00', '2024-02-10 23:00:00'),
(201, 15, 7, '2024-02-10 06:00:00', '2024-02-10 23:59:00'),

-- FREE on Feb 10 2024 (Different days)
(101, 11, 2, '2024-02-11 08:00:00', '2024-02-11 20:00:00'),
(102, 15, 3, '2024-02-10 06:00:00', '2024-02-10 08:00:00'), -- Ends before 9am
(202, 23, 2, '2024-06-15 08:00:00', '2024-06-16 23:00:00'),
(203, 29, 10, '2024-09-01 08:00:00', '2024-09-07 18:00:00'),

-- Long Term Rentals
(103, 12, 4, '2024-02-01 00:00:00', '2024-03-01 00:00:00'),
(204, 34, 6, '2024-01-01 00:00:00', '2024-12-31 00:00:00'), -- Broadway show occupies theater all year

-- Past/Future
(104, 10, 5, '2023-06-01 10:00:00', '2023-06-01 14:00:00'),
(105, 13, 3, '2025-01-01 09:00:00', '2025-01-05 18:00:00'),
(205, 39, 8, '2025-07-01 05:00:00', '2025-07-10 20:00:00');

-- =============================================
-- 7. EXPENSES
-- =============================================

INSERT INTO productionexpense (expense_id, production_id, expense_type, amount, expense_date, description) VALUES 
(800, 10, 'Catering', 1200.50, '2023-01-15', 'Lunch'),
(801, 10, 'Props', 500.00, '2023-01-20', 'Swords'),
(802, 11, 'Sound', 5000.00, '2024-02-05', 'Speakers'),
(803, 12, 'Costume', 3000.00, '2024-01-10', 'Dresses'),
(804, 12, 'Makeup', 1500.00, '2024-01-11', 'Prosthetics'),
(805, 13, 'VFX', 10000.00, '2025-02-01', 'CGI render'),
(806, 19, 'Travel', 2000.00, '2024-09-01', 'Flights'),
-- NEW EXPENSES
(807, 20, 'Pyrotechnics', 15000.00, '2024-06-01', 'Explosions'),
(808, 21, 'Flowers', 800.00, '2023-03-14', 'Wedding Scene'),
(809, 25, 'CGI', 50000.00, '2025-06-01', 'Monster render'),
(810, 28, 'Catering', 4000.00, '2024-02-10', 'Champagne'),
(811, 34, 'Marketing', 10000.00, '2024-01-01', 'Billboards'),
(812, 39, 'Cars', 30000.00, '2025-06-15', 'Stunt cars purchase');
-- =============================================
-- 1. NEW 2025 PRODUCTIONS (IDs 50-61)
-- One major production per month to anchor the daily data
-- =============================================

INSERT INTO production (production_id, title, production_type, contract_hire_date, contract_expiration_date, partner_id) VALUES 
(50, '2025 Jan: Winter Gala', 'Event', '2025-01-01', '2025-01-31', 100),
(51, '2025 Feb: Fashion Week', 'Event', '2025-02-01', '2025-02-28', 102),
(52, '2025 Mar: Spring Play', 'General', '2025-03-01', '2025-03-31', 106),
(53, '2025 Apr: Comedy Tour', 'Event', '2025-04-01', '2025-04-30', 103),
(54, '2025 May: Indie Film', 'General', '2025-05-01', '2025-05-31', 101),
(55, '2025 Jun: Summer Blockbuster', 'General', '2025-06-01', '2025-06-30', 104),
(56, '2025 Jul: Music Festival', 'Event', '2025-07-01', '2025-07-31', 103),
(57, '2025 Aug: Action Sequel', 'General', '2025-08-01', '2025-08-31', 104),
(58, '2025 Sep: Documentary', 'General', '2025-09-01', '2025-09-30', 101),
(59, '2025 Oct: Horror Special', 'General', '2025-10-01', '2025-10-31', 108),
(60, '2025 Nov: Awards Show', 'Event', '2025-11-01', '2025-11-30', 102),
(61, '2025 Dec: Holiday Special', 'Event', '2025-12-01', '2025-12-31', 100);

-- Link them to subtypes (Required for your schema logic)
INSERT INTO eventproduction (production_id, event_type, location, audience_capacity) VALUES
(50, 'Gala', 'Ballroom', 500), (51, 'Show', 'Runway', 1000), (53, 'Standup', 'Club', 200),
(56, 'Festival', 'Park', 5000), (60, 'Award', 'Theater', 2000), (61, 'Concert', 'Hall', 1500);

INSERT INTO generalproduction (production_id, genre, plan_release_quarter, plan_release_year) VALUES
(52, 'Drama', 4, 2025), (54, 'Drama', 4, 2025), (55, 'Action', 2, 2026),
(57, 'Action', 3, 2026), (58, 'Doc', 1, 2026), (59, 'Horror', 4, 2025);

-- =============================================
-- 2. PRODUCTION SCHEDULES (2025)
-- ~20 Entries Per Month (IDs 2000+)
-- =============================================

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES
-- JAN 2025 (Winter Gala)
(2001, 50, 1, '2025-01-02 09:00:00', '2025-01-02 17:00:00', 'Rehearsal', 'Hall A'),
(2002, 50, 2, '2025-01-03 10:00:00', '2025-01-03 14:00:00', 'Fitting', 'Wardrobe'),
(2003, 50, 24, '2025-01-05 09:00:00', '2025-01-05 18:00:00', 'Set Prep', 'Stage'),
(2004, 50, 25, '2025-01-08 12:00:00', '2025-01-08 16:00:00', 'Sound Check', 'Stage'),
(2005, 50, 27, '2025-01-10 18:00:00', '2025-01-10 22:00:00', 'Live Show', 'Main Stage'),
(2006, 50, 1, '2025-01-12 09:00:00', '2025-01-12 12:00:00', 'Interview', 'Lobby'),
(2007, 50, 9, '2025-01-15 08:00:00', '2025-01-15 12:00:00', 'Makeup', 'Room 101'),
(2008, 50, 10, '2025-01-15 08:00:00', '2025-01-15 12:00:00', 'Makeup', 'Room 102'),
(2009, 50, 35, '2025-01-18 09:00:00', '2025-01-18 17:00:00', 'Directing', 'Control Room'),
(2010, 50, 24, '2025-01-20 10:00:00', '2025-01-20 15:00:00', 'Photo Shoot', 'Garden'),
(2011, 50, 25, '2025-01-22 09:00:00', '2025-01-22 17:00:00', 'Training', 'Gym'),
(2012, 50, 27, '2025-01-25 19:00:00', '2025-01-25 23:00:00', 'VIP Dinner', 'Restaurant'),
(2013, 50, 28, '2025-01-26 10:00:00', '2025-01-26 14:00:00', 'Script Read', 'Office'),
(2014, 50, 29, '2025-01-27 09:00:00', '2025-01-27 18:00:00', 'Filming', 'Studio B'),
(2015, 50, 30, '2025-01-28 09:00:00', '2025-01-28 18:00:00', 'Filming', 'Studio B'),
(2016, 50, 33, '2025-01-29 07:00:00', '2025-01-29 12:00:00', 'Set Build', 'Studio B'),
(2017, 50, 34, '2025-01-29 07:00:00', '2025-01-29 12:00:00', 'Costume Prep', 'Wardrobe'),
(2018, 50, 1, '2025-01-30 09:00:00', '2025-01-30 17:00:00', 'Wrap Up', 'Office'),
(2019, 50, 2, '2025-01-30 09:00:00', '2025-01-30 17:00:00', 'Wrap Up', 'Office'),
(2020, 50, 3, '2025-01-31 09:00:00', '2025-01-31 17:00:00', 'Planning', 'Zoom'),

-- FEB 2025 (Fashion Week)
(2021, 51, 4, '2025-02-01 09:00:00', '2025-02-01 17:00:00', 'Runway Prep', 'Backstage'),
(2022, 51, 6, '2025-02-02 10:00:00', '2025-02-02 14:00:00', 'Voiceover', 'Booth'),
(2023, 51, 27, '2025-02-03 08:00:00', '2025-02-03 20:00:00', 'Modeling', 'Runway'),
(2024, 51, 24, '2025-02-05 09:00:00', '2025-02-05 12:00:00', 'Interview', 'Press Room'),
(2025, 51, 11, '2025-02-06 07:00:00', '2025-02-06 23:00:00', 'Sewing', 'Workshop'),
(2026, 51, 12, '2025-02-06 07:00:00', '2025-02-06 23:00:00', 'Sewing', 'Workshop'),
(2027, 51, 9, '2025-02-08 16:00:00', '2025-02-08 20:00:00', 'Makeup', 'Backstage'),
(2028, 51, 27, '2025-02-10 09:00:00', '2025-02-10 11:00:00', 'Meeting', 'Office'),
(2029, 51, 28, '2025-02-12 18:00:00', '2025-02-12 22:00:00', 'Event Guest', 'VIP Area'),
(2030, 51, 25, '2025-02-14 19:00:00', '2025-02-14 23:00:00', 'Gala Dinner', 'Ballroom'),
(2031, 51, 35, '2025-02-15 09:00:00', '2025-02-15 17:00:00', 'Scouting', 'City'),
(2032, 51, 36, '2025-02-16 09:00:00', '2025-02-16 17:00:00', 'Scouting', 'City'),
(2033, 51, 1, '2025-02-18 10:00:00', '2025-02-18 15:00:00', 'Rehearsal', 'Studio'),
(2034, 51, 2, '2025-02-20 09:00:00', '2025-02-20 18:00:00', 'Shooting', 'Location'),
(2035, 51, 3, '2025-02-22 09:00:00', '2025-02-22 18:00:00', 'Shooting', 'Location'),
(2036, 51, 24, '2025-02-24 08:00:00', '2025-02-24 12:00:00', 'Travel', 'Airport'),
(2037, 51, 25, '2025-02-25 09:00:00', '2025-02-25 17:00:00', 'Stunt Prep', 'Gym'),
(2038, 51, 39, '2025-02-26 10:00:00', '2025-02-26 16:00:00', 'Safety Check', 'Site'),
(2039, 51, 40, '2025-02-27 10:00:00', '2025-02-27 16:00:00', 'Security', 'Site'),
(2040, 51, 17, '2025-02-28 09:00:00', '2025-02-28 17:00:00', 'Accounting', 'Office'),

-- MAR 2025 (Spring Play)
(2041, 52, 29, '2025-03-01 09:00:00', '2025-03-01 17:00:00', 'Table Read', 'Room A'),
(2042, 52, 30, '2025-03-02 09:00:00', '2025-03-02 17:00:00', 'Table Read', 'Room A'),
(2043, 52, 21, '2025-03-03 10:00:00', '2025-03-03 14:00:00', 'Costume Fit', 'Wardrobe'),
(2044, 52, 22, '2025-03-05 10:00:00', '2025-03-05 14:00:00', 'Costume Fit', 'Wardrobe'),
(2045, 52, 11, '2025-03-07 08:00:00', '2025-03-07 18:00:00', 'Design', 'Studio'),
(2046, 52, 13, '2025-03-08 09:00:00', '2025-03-08 17:00:00', 'Blocking', 'Stage'),
(2047, 52, 29, '2025-03-10 09:00:00', '2025-03-10 12:00:00', 'Rehearsal', 'Stage'),
(2048, 52, 30, '2025-03-12 13:00:00', '2025-03-12 17:00:00', 'Rehearsal', 'Stage'),
(2049, 52, 19, '2025-03-14 08:00:00', '2025-03-14 18:00:00', 'Lighting', 'Stage'),
(2050, 52, 20, '2025-03-15 08:00:00', '2025-03-15 18:00:00', 'Sound', 'Stage'),
(2051, 52, 29, '2025-03-17 19:00:00', '2025-03-17 22:00:00', 'Dress Rehearsal', 'Stage'),
(2052, 52, 30, '2025-03-18 19:00:00', '2025-03-18 22:00:00', 'Dress Rehearsal', 'Stage'),
(2053, 52, 29, '2025-03-20 19:00:00', '2025-03-20 23:00:00', 'Opening Night', 'Stage'),
(2054, 52, 30, '2025-03-21 19:00:00', '2025-03-21 23:00:00', 'Performance', 'Stage'),
(2055, 52, 29, '2025-03-22 19:00:00', '2025-03-22 23:00:00', 'Performance', 'Stage'),
(2056, 52, 30, '2025-03-23 14:00:00', '2025-03-23 17:00:00', 'Matinee', 'Stage'),
(2057, 52, 17, '2025-03-25 10:00:00', '2025-03-25 12:00:00', 'Finance Mtg', 'Office'),
(2058, 52, 18, '2025-03-28 09:00:00', '2025-03-28 17:00:00', 'Load Out', 'Loading Dock'),
(2059, 52, 39, '2025-03-29 09:00:00', '2025-03-29 17:00:00', 'Cleanup', 'Stage'),
(2060, 52, 13, '2025-03-31 10:00:00', '2025-03-31 12:00:00', 'Post-Mortem', 'Office'),

-- APR 2025 (Comedy Tour)
(2061, 53, 3, '2025-04-01 19:00:00', '2025-04-01 21:00:00', 'Show 1', 'Club A'),
(2062, 53, 3, '2025-04-02 19:00:00', '2025-04-02 21:00:00', 'Show 2', 'Club B'),
(2063, 53, 3, '2025-04-03 19:00:00', '2025-04-03 21:00:00', 'Show 3', 'Club C'),
(2064, 53, 3, '2025-04-04 19:00:00', '2025-04-04 21:00:00', 'Show 4', 'Club D'),
(2065, 53, 17, '2025-04-05 10:00:00', '2025-04-05 14:00:00', 'Logistics', 'HQ'),
(2066, 53, 20, '2025-04-06 16:00:00', '2025-04-06 18:00:00', 'Mic Check', 'Club E'),
(2067, 53, 3, '2025-04-07 19:00:00', '2025-04-07 21:00:00', 'Show 5', 'Club E'),
(2068, 53, 3, '2025-04-08 19:00:00', '2025-04-08 21:00:00', 'Show 6', 'Club F'),
(2069, 53, 3, '2025-04-10 09:00:00', '2025-04-10 13:00:00', 'Travel', 'Train'),
(2070, 53, 3, '2025-04-12 19:00:00', '2025-04-12 21:00:00', 'Show 7', 'Theater'),
(2071, 53, 9, '2025-04-12 18:00:00', '2025-04-12 19:00:00', 'Touchup', 'Dressing Room'),
(2072, 53, 3, '2025-04-15 19:00:00', '2025-04-15 21:00:00', 'Show 8', 'Theater'),
(2073, 53, 3, '2025-04-18 19:00:00', '2025-04-18 21:00:00', 'Show 9', 'Theater'),
(2074, 53, 3, '2025-04-20 19:00:00', '2025-04-20 21:00:00', 'Show 10', 'Theater'),
(2075, 53, 18, '2025-04-22 09:00:00', '2025-04-22 17:00:00', 'Load Truck', 'Backstage'),
(2076, 53, 3, '2025-04-24 19:00:00', '2025-04-24 21:00:00', 'Final Show', 'Arena'),
(2077, 53, 15, '2025-04-25 10:00:00', '2025-04-25 12:00:00', 'Review', 'Office'),
(2078, 53, 3, '2025-04-27 10:00:00', '2025-04-27 14:00:00', 'Podcast', 'Studio'),
(2079, 53, 1, '2025-04-29 19:00:00', '2025-04-29 21:00:00', 'Guest Spot', 'TV Show'),
(2080, 53, 17, '2025-04-30 09:00:00', '2025-04-30 17:00:00', 'Billing', 'Office'),

-- MAY 2025 (Indie Film)
(2081, 54, 28, '2025-05-01 06:00:00', '2025-05-01 18:00:00', 'Shoot Day 1', 'Location'),
(2082, 54, 4, '2025-05-01 06:00:00', '2025-05-01 18:00:00', 'Shoot Day 1', 'Location'),
(2083, 54, 28, '2025-05-02 06:00:00', '2025-05-02 18:00:00', 'Shoot Day 2', 'Location'),
(2084, 54, 4, '2025-05-02 06:00:00', '2025-05-02 18:00:00', 'Shoot Day 2', 'Location'),
(2085, 54, 36, '2025-05-03 06:00:00', '2025-05-03 18:00:00', 'Directing', 'Location'),
(2086, 54, 10, '2025-05-04 05:00:00', '2025-05-04 09:00:00', 'FX Makeup', 'Trailer'),
(2087, 54, 28, '2025-05-05 06:00:00', '2025-05-05 18:00:00', 'Shoot Day 3', 'Studio'),
(2088, 54, 4, '2025-05-07 06:00:00', '2025-05-07 18:00:00', 'Shoot Day 4', 'Studio'),
(2089, 54, 28, '2025-05-09 06:00:00', '2025-05-09 18:00:00', 'Shoot Day 5', 'Studio'),
(2090, 54, 33, '2025-05-10 06:00:00', '2025-05-10 18:00:00', 'Makeup', 'Trailer'),
(2091, 54, 12, '2025-05-12 06:00:00', '2025-05-12 18:00:00', 'Wardrobe', 'Trailer'),
(2092, 54, 36, '2025-05-14 09:00:00', '2025-05-14 17:00:00', 'Editing', 'Suite'),
(2093, 54, 15, '2025-05-15 10:00:00', '2025-05-15 12:00:00', 'Producer Mtg', 'Office'),
(2094, 54, 28, '2025-05-17 06:00:00', '2025-05-17 18:00:00', 'Shoot Day 6', 'Desert'),
(2095, 54, 4, '2025-05-19 06:00:00', '2025-05-19 18:00:00', 'Shoot Day 7', 'Desert'),
(2096, 54, 39, '2025-05-20 06:00:00', '2025-05-20 18:00:00', 'Pyro FX', 'Desert'),
(2097, 54, 36, '2025-05-22 09:00:00', '2025-05-22 17:00:00', 'Editing', 'Suite'),
(2098, 54, 28, '2025-05-25 09:00:00', '2025-05-25 17:00:00', 'ADR', 'Audio Booth'),
(2099, 54, 4, '2025-05-28 09:00:00', '2025-05-28 17:00:00', 'ADR', 'Audio Booth'),
(2100, 54, 36, '2025-05-30 09:00:00', '2025-05-30 17:00:00', 'Final Cut', 'Suite'),

-- JUN 2025 (Summer Blockbuster)
(2101, 55, 25, '2025-06-01 07:00:00', '2025-06-01 19:00:00', 'Stunt Scene', 'Set A'),
(2102, 55, 5, '2025-06-01 07:00:00', '2025-06-01 19:00:00', 'Stunt Double', 'Set A'),
(2103, 55, 25, '2025-06-02 07:00:00', '2025-06-02 19:00:00', 'Fight Scene', 'Set B'),
(2104, 55, 37, '2025-06-03 07:00:00', '2025-06-03 19:00:00', 'Directing', 'Set B'),
(2105, 55, 39, '2025-06-04 07:00:00', '2025-06-04 19:00:00', 'Explosions', 'Set B'),
(2106, 55, 25, '2025-06-06 07:00:00', '2025-06-06 19:00:00', 'Chase Seq', 'Streets'),
(2107, 55, 5, '2025-06-06 07:00:00', '2025-06-06 19:00:00', 'Stunt Drive', 'Streets'),
(2108, 55, 40, '2025-06-06 05:00:00', '2025-06-06 20:00:00', 'Crowd Control', 'Streets'),
(2109, 55, 25, '2025-06-09 09:00:00', '2025-06-09 17:00:00', 'Green Screen', 'Studio'),
(2110, 55, 25, '2025-06-11 09:00:00', '2025-06-11 17:00:00', 'Green Screen', 'Studio'),
(2111, 55, 9, '2025-06-12 07:00:00', '2025-06-12 12:00:00', 'Prosthetics', 'Trailer'),
(2112, 55, 25, '2025-06-15 07:00:00', '2025-06-15 19:00:00', 'Finale Shoot', 'Rooftop'),
(2113, 55, 37, '2025-06-15 07:00:00', '2025-06-15 19:00:00', 'Directing', 'Rooftop'),
(2114, 55, 18, '2025-06-18 08:00:00', '2025-06-18 20:00:00', 'Transport', 'Road'),
(2115, 55, 25, '2025-06-20 09:00:00', '2025-06-20 15:00:00', 'Press Junket', 'Hotel'),
(2116, 55, 1, '2025-06-22 10:00:00', '2025-06-22 14:00:00', 'Cameo Shoot', 'Studio'),
(2117, 55, 37, '2025-06-25 09:00:00', '2025-06-25 17:00:00', 'Edit Review', 'Suite'),
(2118, 55, 15, '2025-06-27 10:00:00', '2025-06-27 12:00:00', 'Budget Check', 'Office'),
(2119, 55, 25, '2025-06-29 19:00:00', '2025-06-29 23:00:00', 'Wrap Party', 'Club'),
(2120, 55, 37, '2025-06-30 10:00:00', '2025-06-30 12:00:00', 'Handoff', 'Office'),

-- JUL 2025 (Music Festival)
(2121, 56, 24, '2025-07-01 10:00:00', '2025-07-01 14:00:00', 'Sound Check', 'Stage A'),
(2122, 56, 27, '2025-07-02 10:00:00', '2025-07-02 14:00:00', 'Rehearsal', 'Stage B'),
(2123, 56, 17, '2025-07-03 08:00:00', '2025-07-03 20:00:00', 'Site Prep', 'Park'),
(2124, 56, 40, '2025-07-04 08:00:00', '2025-07-04 23:00:00', 'Security', 'Gates'),
(2125, 56, 24, '2025-07-04 20:00:00', '2025-07-04 22:00:00', 'Performance', 'Main Stage'),
(2126, 56, 27, '2025-07-05 18:00:00', '2025-07-05 19:00:00', 'Intro Host', 'Main Stage'),
(2127, 56, 20, '2025-07-06 08:00:00', '2025-07-06 23:00:00', 'Audio Eng', 'Booth'),
(2128, 56, 19, '2025-07-07 08:00:00', '2025-07-07 23:00:00', 'Lighting', 'Booth'),
(2129, 56, 24, '2025-07-10 12:00:00', '2025-07-10 14:00:00', 'Meet Greet', 'Tent'),
(2130, 56, 3, '2025-07-12 19:00:00', '2025-07-12 20:00:00', 'MC Duty', 'Stage A'),
(2131, 56, 18, '2025-07-15 08:00:00', '2025-07-15 16:00:00', 'Restock', 'Warehouse'),
(2132, 56, 24, '2025-07-18 10:00:00', '2025-07-18 12:00:00', 'Interview', 'Radio'),
(2133, 56, 17, '2025-07-20 09:00:00', '2025-07-20 17:00:00', 'Management', 'Trailer'),
(2134, 56, 40, '2025-07-22 08:00:00', '2025-07-22 20:00:00', 'Security', 'Perimeter'),
(2135, 56, 39, '2025-07-25 21:00:00', '2025-07-25 21:30:00', 'Fireworks', 'Sky'),
(2136, 56, 24, '2025-07-25 22:00:00', '2025-07-25 23:00:00', 'Encore', 'Stage A'),
(2137, 56, 17, '2025-07-28 09:00:00', '2025-07-28 17:00:00', 'Teardown', 'Park'),
(2138, 56, 18, '2025-07-29 09:00:00', '2025-07-29 17:00:00', 'Transport', 'Park'),
(2139, 56, 15, '2025-07-30 10:00:00', '2025-07-30 12:00:00', 'Debrief', 'Office'),
(2140, 56, 17, '2025-07-31 09:00:00', '2025-07-31 17:00:00', 'Closeout', 'Office'),

-- AUG 2025 (Action Sequel)
(2141, 57, 25, '2025-08-01 07:00:00', '2025-08-01 19:00:00', 'Training', 'Gym'),
(2142, 57, 4, '2025-08-01 07:00:00', '2025-08-01 19:00:00', 'Training', 'Gym'),
(2143, 57, 37, '2025-08-02 09:00:00', '2025-08-02 17:00:00', 'Pre-Vis', 'Office'),
(2144, 57, 25, '2025-08-04 06:00:00', '2025-08-04 18:00:00', 'Shoot', 'Set 1'),
(2145, 57, 4, '2025-08-05 06:00:00', '2025-08-05 18:00:00', 'Shoot', 'Set 1'),
(2146, 57, 25, '2025-08-07 06:00:00', '2025-08-07 18:00:00', 'Shoot', 'Set 2'),
(2147, 57, 4, '2025-08-08 06:00:00', '2025-08-08 18:00:00', 'Shoot', 'Set 2'),
(2148, 57, 5, '2025-08-10 06:00:00', '2025-08-10 18:00:00', 'Stunts', 'Set 3'),
(2149, 57, 39, '2025-08-11 08:00:00', '2025-08-11 12:00:00', 'Rigging', 'Set 3'),
(2150, 57, 25, '2025-08-12 06:00:00', '2025-08-12 18:00:00', 'Wire Work', 'Studio'),
(2151, 57, 4, '2025-08-14 06:00:00', '2025-08-14 18:00:00', 'Wire Work', 'Studio'),
(2152, 57, 9, '2025-08-15 05:00:00', '2025-08-15 09:00:00', 'Makeup', 'Trailer'),
(2153, 57, 12, '2025-08-15 05:00:00', '2025-08-15 09:00:00', 'Costume', 'Trailer'),
(2154, 57, 25, '2025-08-18 06:00:00', '2025-08-18 18:00:00', 'Battle Scene', 'Field'),
(2155, 57, 4, '2025-08-18 06:00:00', '2025-08-18 18:00:00', 'Battle Scene', 'Field'),
(2156, 57, 40, '2025-08-18 05:00:00', '2025-08-18 20:00:00', 'Set Security', 'Field'),
(2157, 57, 37, '2025-08-20 07:00:00', '2025-08-20 19:00:00', 'Directing', 'Field'),
(2158, 57, 25, '2025-08-25 09:00:00', '2025-08-25 17:00:00', 'ADR', 'Audio'),
(2159, 57, 15, '2025-08-28 10:00:00', '2025-08-28 12:00:00', 'Update Mtg', 'Office'),
(2160, 57, 37, '2025-08-30 09:00:00', '2025-08-30 17:00:00', 'Assembly', 'Edit Bay'),

-- SEP 2025 (Documentary)
(2161, 58, 13, '2025-09-01 08:00:00', '2025-09-01 18:00:00', 'Interview 1', 'Location'),
(2162, 58, 1, '2025-09-01 10:00:00', '2025-09-01 12:00:00', 'Interviewee', 'Location'),
(2163, 58, 13, '2025-09-03 08:00:00', '2025-09-03 18:00:00', 'Interview 2', 'Location'),
(2164, 58, 2, '2025-09-03 10:00:00', '2025-09-03 12:00:00', 'Interviewee', 'Location'),
(2165, 58, 13, '2025-09-05 08:00:00', '2025-09-05 18:00:00', 'B-Roll', 'City'),
(2166, 58, 19, '2025-09-05 08:00:00', '2025-09-05 18:00:00', 'Camera Op', 'City'),
(2167, 58, 13, '2025-09-08 08:00:00', '2025-09-08 18:00:00', 'B-Roll', 'Park'),
(2168, 58, 6, '2025-09-10 10:00:00', '2025-09-10 14:00:00', 'Narration', 'Studio'),
(2169, 58, 13, '2025-09-12 09:00:00', '2025-09-12 17:00:00', 'Editing', 'Bay 1'),
(2170, 58, 13, '2025-09-15 09:00:00', '2025-09-15 17:00:00', 'Editing', 'Bay 1'),
(2171, 58, 15, '2025-09-17 10:00:00', '2025-09-17 11:00:00', 'Review', 'Bay 1'),
(2172, 58, 13, '2025-09-19 09:00:00', '2025-09-19 17:00:00', 'Color Grade', 'Lab'),
(2173, 58, 20, '2025-09-20 09:00:00', '2025-09-20 17:00:00', 'Sound Mix', 'Lab'),
(2174, 58, 13, '2025-09-22 08:00:00', '2025-09-22 18:00:00', 'Reshoot', 'Street'),
(2175, 58, 1, '2025-09-22 10:00:00', '2025-09-22 11:00:00', 'Pickup', 'Street'),
(2176, 58, 13, '2025-09-25 09:00:00', '2025-09-25 17:00:00', 'Final Edit', 'Bay 1'),
(2177, 58, 15, '2025-09-27 10:00:00', '2025-09-27 12:00:00', 'Signoff', 'Office'),
(2178, 58, 13, '2025-09-28 09:00:00', '2025-09-28 17:00:00', 'Export', 'Lab'),
(2179, 58, 17, '2025-09-29 09:00:00', '2025-09-29 17:00:00', 'Distribution', 'Office'),
(2180, 58, 13, '2025-09-30 18:00:00', '2025-09-30 20:00:00', 'Premiere', 'Theater'),

-- OCT 2025 (Horror Special)
(2181, 59, 6, '2025-10-01 18:00:00', '2025-10-02 04:00:00', 'Night Shoot', 'Woods'),
(2182, 59, 21, '2025-10-01 18:00:00', '2025-10-02 04:00:00', 'Night Shoot', 'Woods'),
(2183, 59, 10, '2025-10-01 16:00:00', '2025-10-01 20:00:00', 'Gore FX', 'Tent'),
(2184, 59, 37, '2025-10-03 18:00:00', '2025-10-04 04:00:00', 'Directing', 'House'),
(2185, 59, 6, '2025-10-05 18:00:00', '2025-10-06 04:00:00', 'Night Shoot', 'House'),
(2186, 59, 21, '2025-10-05 18:00:00', '2025-10-06 04:00:00', 'Night Shoot', 'House'),
(2187, 59, 10, '2025-10-07 16:00:00', '2025-10-07 20:00:00', 'Prosthetics', 'Tent'),
(2188, 59, 19, '2025-10-10 18:00:00', '2025-10-11 04:00:00', 'Camera', 'House'),
(2189, 59, 20, '2025-10-12 18:00:00', '2025-10-13 04:00:00', 'Sound', 'House'),
(2190, 59, 6, '2025-10-15 10:00:00', '2025-10-15 14:00:00', 'Screams', 'Audio Booth'),
(2191, 59, 21, '2025-10-17 18:00:00', '2025-10-18 02:00:00', 'Chase Scene', 'Street'),
(2192, 59, 39, '2025-10-20 18:00:00', '2025-10-20 22:00:00', 'Smoke FX', 'Street'),
(2193, 59, 37, '2025-10-22 09:00:00', '2025-10-22 17:00:00', 'Editing', 'Suite'),
(2194, 59, 15, '2025-10-24 10:00:00', '2025-10-24 12:00:00', 'Producer Review', 'Suite'),
(2195, 59, 6, '2025-10-26 18:00:00', '2025-10-26 22:00:00', 'Reshoot', 'Woods'),
(2196, 59, 10, '2025-10-26 16:00:00', '2025-10-26 18:00:00', 'Makeup', 'Tent'),
(2197, 59, 37, '2025-10-28 09:00:00', '2025-10-28 17:00:00', 'Final Cut', 'Suite'),
(2198, 59, 17, '2025-10-30 09:00:00', '2025-10-30 17:00:00', 'Wrap', 'Office'),
(2199, 59, 6, '2025-10-31 18:00:00', '2025-10-31 22:00:00', 'Premiere', 'Theater'),
(2200, 59, 21, '2025-10-31 18:00:00', '2025-10-31 22:00:00', 'Premiere', 'Theater'),

-- NOV 2025 (Awards Show)
(2201, 60, 24, '2025-11-01 10:00:00', '2025-11-01 14:00:00', 'Host Prep', 'Studio'),
(2202, 60, 25, '2025-11-02 10:00:00', '2025-11-02 12:00:00', 'Presenter', 'Studio'),
(2203, 60, 27, '2025-11-03 10:00:00', '2025-11-03 12:00:00', 'Presenter', 'Studio'),
(2204, 60, 28, '2025-11-04 10:00:00', '2025-11-04 12:00:00', 'Presenter', 'Studio'),
(2205, 60, 11, '2025-11-05 08:00:00', '2025-11-05 20:00:00', 'Gowns', 'Wardrobe'),
(2206, 60, 17, '2025-11-07 09:00:00', '2025-11-07 17:00:00', 'Planning', 'Office'),
(2207, 60, 19, '2025-11-10 08:00:00', '2025-11-10 18:00:00', 'Rigging', 'Stage'),
(2208, 60, 20, '2025-11-12 08:00:00', '2025-11-12 18:00:00', 'Audio', 'Stage'),
(2209, 60, 24, '2025-11-14 09:00:00', '2025-11-14 17:00:00', 'Rehearsal', 'Stage'),
(2210, 60, 25, '2025-11-15 10:00:00', '2025-11-15 12:00:00', 'Rehearsal', 'Stage'),
(2211, 60, 40, '2025-11-18 08:00:00', '2025-11-18 20:00:00', 'Security', 'Venue'),
(2212, 60, 9, '2025-11-20 12:00:00', '2025-11-20 17:00:00', 'Makeup', 'Green Room'),
(2213, 60, 10, '2025-11-20 12:00:00', '2025-11-20 17:00:00', 'Hair', 'Green Room'),
(2214, 60, 24, '2025-11-20 18:00:00', '2025-11-20 23:00:00', 'Hosting', 'Main Stage'),
(2215, 60, 25, '2025-11-20 19:00:00', '2025-11-20 23:00:00', 'Awards', 'Audience'),
(2216, 60, 27, '2025-11-20 19:00:00', '2025-11-20 23:00:00', 'Awards', 'Audience'),
(2217, 60, 15, '2025-11-20 19:00:00', '2025-11-20 23:00:00', 'VIP', 'Audience'),
(2218, 60, 18, '2025-11-21 08:00:00', '2025-11-21 16:00:00', 'Teardown', 'Venue'),
(2219, 60, 17, '2025-11-23 09:00:00', '2025-11-23 17:00:00', 'Accounting', 'Office'),
(2220, 60, 15, '2025-11-25 10:00:00', '2025-11-25 12:00:00', 'Review', 'Office'),

-- DEC 2025 (Holiday Special)
(2221, 61, 24, '2025-12-01 09:00:00', '2025-12-01 17:00:00', 'Rehearsal', 'Studio'),
(2222, 61, 3, '2025-12-02 10:00:00', '2025-12-02 14:00:00', 'Guest', 'Studio'),
(2223, 61, 11, '2025-12-04 08:00:00', '2025-12-04 18:00:00', 'Costume', 'Wardrobe'),
(2224, 61, 19, '2025-12-06 08:00:00', '2025-12-06 18:00:00', 'Lights', 'Stage'),
(2225, 61, 20, '2025-12-07 08:00:00', '2025-12-07 18:00:00', 'Sound', 'Stage'),
(2226, 61, 24, '2025-12-09 18:00:00', '2025-12-09 21:00:00', 'Show 1', 'Stage'),
(2227, 61, 24, '2025-12-10 18:00:00', '2025-12-10 21:00:00', 'Show 2', 'Stage'),
(2228, 61, 3, '2025-12-11 18:00:00', '2025-12-11 21:00:00', 'Show 3', 'Stage'),
(2229, 61, 24, '2025-12-12 18:00:00', '2025-12-12 21:00:00', 'Show 4', 'Stage'),
(2230, 61, 9, '2025-12-12 16:00:00', '2025-12-12 18:00:00', 'Makeup', 'Backstage'),
(2231, 61, 24, '2025-12-14 18:00:00', '2025-12-14 21:00:00', 'Show 5', 'Stage'),
(2232, 61, 3, '2025-12-16 18:00:00', '2025-12-16 21:00:00', 'Show 6', 'Stage'),
(2233, 61, 24, '2025-12-18 18:00:00', '2025-12-18 21:00:00', 'Show 7', 'Stage'),
(2234, 61, 24, '2025-12-20 18:00:00', '2025-12-20 21:00:00', 'Final Show', 'Stage'),
(2235, 61, 15, '2025-12-21 19:00:00', '2025-12-21 23:00:00', 'Party', 'Hotel'),
(2236, 61, 17, '2025-12-22 09:00:00', '2025-12-22 17:00:00', 'Wrap', 'Office'),
(2237, 61, 18, '2025-12-23 09:00:00', '2025-12-23 17:00:00', 'Load Out', 'Dock'),
(2238, 61, 1, '2025-12-24 10:00:00', '2025-12-24 12:00:00', 'Charity', 'Hospital'),
(2239, 61, 2, '2025-12-24 10:00:00', '2025-12-24 12:00:00', 'Charity', 'Hospital'),
(2240, 61, 17, '2025-12-30 09:00:00', '2025-12-30 17:00:00', 'Year End', 'Office');

-- =============================================
-- 3. RENTAL USAGE (2025)
-- Monthly coverage (IDs 3000+)
-- =============================================

INSERT INTO rentalusage (usage_id, production_id, place_id, start_time, end_time) VALUES
-- JAN
(3001, 50, 5, '2025-01-02 08:00:00', '2025-01-05 18:00:00'),
(3002, 50, 6, '2025-01-10 08:00:00', '2025-01-10 23:00:00'),
(3003, 50, 3, '2025-01-27 08:00:00', '2025-01-29 18:00:00'),

-- FEB
(3004, 51, 10, '2025-02-03 08:00:00', '2025-02-03 22:00:00'),
(3005, 51, 6, '2025-02-14 08:00:00', '2025-02-14 23:00:00'),
(3006, 51, 4, '2025-02-20 08:00:00', '2025-02-22 18:00:00'),

-- MAR
(3007, 52, 1, '2025-03-08 08:00:00', '2025-03-23 23:00:00'), -- Long rental for Play
(3008, 52, 6, '2025-03-01 09:00:00', '2025-03-02 17:00:00'),

-- APR
(3009, 53, 9, '2025-04-01 18:00:00', '2025-04-04 23:00:00'),
(3010, 53, 1, '2025-04-12 18:00:00', '2025-04-20 23:00:00'),
(3011, 53, 7, '2025-04-24 08:00:00', '2025-04-24 23:00:00'),

-- MAY
(3012, 54, 4, '2025-05-01 06:00:00', '2025-05-05 18:00:00'),
(3013, 54, 3, '2025-05-07 06:00:00', '2025-05-10 18:00:00'),
(3014, 54, 8, '2025-05-17 06:00:00', '2025-05-20 18:00:00'),

-- JUN
(3015, 55, 3, '2025-06-09 08:00:00', '2025-06-11 18:00:00'),
(3016, 55, 4, '2025-06-15 07:00:00', '2025-06-15 19:00:00'),
(3017, 55, 9, '2025-06-29 18:00:00', '2025-06-29 23:59:00'),

-- JUL
(3018, 56, 2, '2025-07-03 08:00:00', '2025-07-06 23:00:00'),
(3019, 56, 5, '2025-07-25 18:00:00', '2025-07-25 23:00:00'),

-- AUG
(3020, 57, 3, '2025-08-12 06:00:00', '2025-08-14 18:00:00'),
(3021, 57, 8, '2025-08-18 06:00:00', '2025-08-20 20:00:00'),

-- SEP
(3022, 58, 4, '2025-09-01 08:00:00', '2025-09-03 18:00:00'),
(3023, 58, 2, '2025-09-08 08:00:00', '2025-09-08 18:00:00'),
(3024, 58, 1, '2025-09-30 18:00:00', '2025-09-30 22:00:00'),

-- OCT
(3025, 59, 8, '2025-10-01 18:00:00', '2025-10-02 04:00:00'),
(3026, 59, 4, '2025-10-05 18:00:00', '2025-10-06 04:00:00'),
(3027, 59, 1, '2025-10-31 18:00:00', '2025-10-31 23:00:00'),

-- NOV
(3028, 60, 3, '2025-11-01 10:00:00', '2025-11-04 14:00:00'),
(3029, 60, 6, '2025-11-18 08:00:00', '2025-11-21 16:00:00'),

-- DEC
(3030, 61, 3, '2025-12-01 09:00:00', '2025-12-02 17:00:00'),
(3031, 61, 5, '2025-12-09 16:00:00', '2025-12-20 22:00:00');

-- =============================================
-- 4. PRODUCTION EXPENSES (2025)
-- (IDs 4000+)
-- =============================================

INSERT INTO productionexpense (expense_id, production_id, expense_type, amount, expense_date, description) VALUES
(4001, 50, 'Catering', 5000.00, '2025-01-25', 'Gala Dinner'),
(4002, 51, 'Venue', 15000.00, '2025-02-10', 'Runway Rental'),
(4003, 52, 'Costume', 2000.00, '2025-03-05', 'Fabric'),
(4004, 53, 'Travel', 8000.00, '2025-04-10', 'Train Tickets'),
(4005, 54, 'Equip', 12000.00, '2025-05-01', 'Camera Rental'),
(4006, 55, 'Pyro', 25000.00, '2025-06-04', 'Explosives'),
(4007, 56, 'Security', 10000.00, '2025-07-04', 'Staffing'),
(4008, 57, 'Insurance', 5000.00, '2025-08-01', 'Stunt Cover'),
(4009, 58, 'Editing', 4000.00, '2025-09-30', 'Post House'),
(4010, 59, 'Makeup', 3000.00, '2025-10-01', 'Blood FX'),
(4011, 60, 'Decor', 20000.00, '2025-11-15', 'Flowers'),
(4012, 61, 'Charity', 1000.00, '2025-12-24', 'Donation');

INSERT INTO partner_personnel (partner_id, name, service_type, personnel_id, contact_hire_date, contact_expiration_date, contract_amount, contact_info) VALUES 
-- --- THE BIG AGENCIES (Shared across multiple actors) ---

-- Creative Artists Agency (CAA) - Represents Leo, Scarlett, Chris H, Zendaya
(300, 'Creative Artists Agency', 'Talent Agency', 1, '2021-01-01', '2026-01-01', 500000.00, 'Agent: Bryan Lourd'),
(301, 'Creative Artists Agency', 'Talent Agency', 4, '2023-01-01', '2026-01-01', 450000.00, 'Agent: Kevin Huvane'),
(302, 'Creative Artists Agency', 'Talent Agency', 25, '2022-05-01', '2025-05-01', 400000.00, 'Agent: Maha Dakhil'),
(303, 'Creative Artists Agency', 'Talent Agency', 27, '2023-06-01', '2027-01-01', 600000.00, 'Agent: Mick Sullivan'),

-- William Morris Endeavor (WME) - Represents Meryl, Julia, Emma, Ryan G, Denzel
(304, 'WME Agency', 'Talent Agency', 2, '2021-05-01', '2025-05-01', 300000.00, 'Agent: Ari Emanuel'),
(305, 'WME Agency', 'Talent Agency', 23, '2022-01-01', '2026-01-01', 350000.00, 'Agent: Richard Weitz'),
(306, 'WME Agency', 'Talent Agency', 24, '2023-01-01', '2027-01-01', 550000.00, 'Agent: Patrick Whitesell'),
(307, 'WME Agency', 'Talent Agency', 26, '2023-01-01', '2026-01-01', 480000.00, 'Agent: Boomer V.'),
(308, 'WME Agency', 'Talent Agency', 30, '2021-09-01', '2025-09-01', 520000.00, 'Agent: Patrick Whitesell'),

-- United Talent Agency (UTA) - Represents Tom Hanks, Timothee
(309, 'United Talent Agency', 'Talent Agency', 3, '2022-01-01', '2027-01-01', 420000.00, 'Agent: Jay Sures'),
(310, 'United Talent Agency', 'Talent Agency', 28, '2023-06-01', '2027-01-01', 580000.00, 'Agent: Jeremy Zimmer'),

-- ICM Partners - Represents Robert DeNiro, Al Pacino
(311, 'ICM Partners', 'Talent Agency', 21, '2021-01-01', '2025-01-01', 250000.00, 'Agent: Chris Silbermann'),
(312, 'ICM Partners', 'Talent Agency', 22, '2021-02-01', '2025-02-01', 260000.00, 'Agent: Ted Chervin'),

-- --- PR FIRMS (Shared across different actors) ---

-- Spotlight PR - Represents Brad Pitt, Jennifer Lawrence
(313, 'Spotlight Public Relations', 'PR Firm', 5, '2021-06-01', '2024-06-01', 120000.00, 'Publicist: Mara Buxbaum'),
(314, 'Spotlight Public Relations', 'PR Firm', 6, '2023-03-01', '2025-03-01', 130000.00, 'Publicist: Simon Halls'),

-- --- SPECIALTY & LEGAL ---

-- Stage Reps (For Viola Davis)
(315, 'Juilliard Representation', 'Stage Mgmt', 29, '2021-08-01', '2025-08-01', 150000.00, 'Contact: Theater Dept'),

-- Temp Agencies (For the Unemployed/Newbie actors)
(316, 'Central Casting', 'Background Casting', 7, '2024-01-01', '2025-01-01', 1000.00, 'Database: 8842'),
(317, 'Central Casting', 'Background Casting', 31, '2024-01-01', '2024-12-31', 500.00, 'Database: 9921'),
(318, 'Central Casting', 'Background Casting', 32, '2024-01-01', '2024-12-31', 500.00, 'Database: 9922'),
(319, 'New Face Talent', 'Development', 8, '2024-02-01', '2025-02-01', 2000.00, 'Scout: John Doe');

-- =============================================
-- "MUSIC" GENRE DATA PACK (2023-2030)
-- IDs 500 - 539
-- =============================================

-- 1. INSERT PRODUCTIONS (Parent Table)
-- We use partner_id 100, 102, 103 (assumed existing from previous data)
INSERT INTO production (production_id, title, production_type, contract_hire_date, contract_expiration_date, partner_id) VALUES 
-- 2023 (IDs 500-504)
(500, 'History of Rock', 'General', '2023-01-15', '2023-06-15', 100),
(501, 'Jazz in the City', 'General', '2023-03-20', '2023-08-20', 102),
(502, 'Pop Star Biography', 'General', '2023-05-10', '2023-11-10', 103),
(503, 'Classical Piano', 'General', '2023-07-01', '2023-12-01', 100),
(504, 'Indie Folk Tales', 'General', '2023-09-15', '2024-02-15', 102),

-- 2024 (IDs 505-509)
(505, 'Electronic Beats', 'General', '2024-02-01', '2024-07-01', 103),
(506, 'Rap Battles Doc', 'General', '2024-04-10', '2024-09-10', 100),
(507, 'Country Roads', 'General', '2024-06-15', '2024-12-15', 102),
(508, 'Blues Legends', 'General', '2024-08-20', '2025-01-20', 103),
(509, 'Opera Behind Scenes', 'General', '2024-10-01', '2025-03-01', 100),

-- 2025 (IDs 510-514)
(510, 'K-Pop Explosion', 'General', '2025-01-10', '2025-06-10', 102),
(511, 'Latin Rhythms', 'General', '2025-03-15', '2025-08-15', 103),
(512, 'Heavy Metal History', 'General', '2025-05-20', '2025-10-20', 100),
(513, 'The Orchestra', 'General', '2025-07-01', '2025-12-01', 102),
(514, 'Acoustic Sessions', 'General', '2025-09-10', '2026-02-10', 103),

-- 2026 (IDs 515-519)
(515, 'Synthwave Future', 'General', '2026-02-01', '2026-07-01', 100),
(516, 'Drumline Drama', 'General', '2026-04-05', '2026-09-05', 102),
(517, 'Violin Virtuoso', 'General', '2026-06-10', '2026-11-10', 103),
(518, 'Reggae Roots', 'General', '2026-08-15', '2027-01-15', 100),
(519, 'Disco Revival', 'General', '2026-10-20', '2027-03-20', 102),

-- 2027 (IDs 520-524)
(520, 'Grunge Era', 'General', '2027-01-05', '2027-06-05', 103),
(521, 'Soul Singers', 'General', '2027-03-10', '2027-08-10', 100),
(522, 'Techno Bunker', 'General', '2027-05-15', '2027-10-15', 102),
(523, 'Choir Competition', 'General', '2027-07-20', '2027-12-20', 103),
(524, 'Banjo Breakdown', 'General', '2027-09-25', '2028-02-25', 100),

-- 2028 (IDs 525-529)
(525, 'Punk Rock Riot', 'General', '2028-02-01', '2028-07-01', 102),
(526, 'Lo-Fi Chill', 'General', '2028-04-10', '2028-09-10', 103),
(527, 'Funk Groove', 'General', '2028-06-15', '2028-11-15', 100),
(528, 'Ska Forever', 'General', '2028-08-20', '2029-01-20', 102),
(529, 'Ambient Sounds', 'General', '2028-10-25', '2029-03-25', 103),

-- 2029 (IDs 530-534)
(530, 'Gospel Voices', 'General', '2029-01-10', '2029-06-10', 100),
(531, 'Dubstep Drop', 'General', '2029-03-15', '2029-08-15', 102),
(532, 'Flamenco Fire', 'General', '2029-05-20', '2029-10-20', 103),
(533, 'Harp Strings', 'General', '2029-07-25', '2029-12-25', 100),
(534, 'Acappella Wars', 'General', '2029-09-30', '2030-02-28', 102),

-- 2030 (IDs 535-539)
(535, 'Future Pop 2030', 'General', '2030-01-05', '2030-06-05', 103),
(536, 'Robot Music', 'General', '2030-03-10', '2030-08-10', 100),
(537, 'Mars Symphony', 'General', '2030-05-15', '2030-10-15', 102),
(538, 'Neo-Classical', 'General', '2030-07-20', '2030-12-20', 103),
(539, 'Global Anthem', 'General', '2030-09-25', '2031-02-25', 100);

-- 2. INSERT GENERAL PRODUCTION DETAILS (Genre = 'Music')
-- Required to satisfy: .where(GeneralProduction.genre == 'Music')
INSERT INTO generalproduction (production_id, genre, plan_release_quarter, plan_release_year) VALUES
-- 2023
(500, 'Music', 4, 2023), (501, 'Music', 3, 2023), (502, 'Music', 1, 2024), 
(503, 'Music', 4, 2023), (504, 'Music', 2, 2024),
-- 2024
(505, 'Music', 3, 2024), (506, 'Music', 4, 2024), (507, 'Music', 1, 2025), 
(508, 'Music', 2, 2025), (509, 'Music', 3, 2025),
-- 2025
(510, 'Music', 4, 2025), (511, 'Music', 1, 2026), (512, 'Music', 2, 2026), 
(513, 'Music', 4, 2025), (514, 'Music', 3, 2026),
-- 2026
(515, 'Music', 3, 2026), (516, 'Music', 4, 2026), (517, 'Music', 1, 2027), 
(518, 'Music', 2, 2027), (519, 'Music', 4, 2026),
-- 2027
(520, 'Music', 3, 2027), (521, 'Music', 4, 2027), (522, 'Music', 1, 2028), 
(523, 'Music', 2, 2028), (524, 'Music', 3, 2028),
-- 2028
(525, 'Music', 4, 2028), (526, 'Music', 1, 2029), (527, 'Music', 2, 2029), 
(528, 'Music', 4, 2028), (529, 'Music', 3, 2029),
-- 2029
(530, 'Music', 3, 2029), (531, 'Music', 4, 2029), (532, 'Music', 1, 2030), 
(533, 'Music', 2, 2030), (534, 'Music', 4, 2029),
-- 2030
(535, 'Music', 3, 2030), (536, 'Music', 4, 2030), (537, 'Music', 1, 2031), 
(538, 'Music', 2, 2031), (539, 'Music', 3, 2031);

-- 3. INSERT ASSIGNMENTS (Linking Personnel)
-- We assign existing personnel (IDs 1-30) to these productions
-- so the API returns "performer_name".
INSERT INTO personnelassignment (personnel_id, production_id, role_title) VALUES
-- 2023 Assignments
(24, 500, 'Narrator'), (3, 500, 'Host'),
(20, 501, 'Pianist'), (17, 501, 'Manager'),
(27, 502, 'Pop Star'), (11, 502, 'Costume Design'),
(15, 503, 'Conductor'),
(28, 504, 'Guitarist'),

-- 2024 Assignments
(1, 505, 'DJ'),
(25, 506, 'Host'), (4, 506, 'Judge'),
(21, 507, 'Singer'),
(22, 508, 'Legend'),
(29, 509, 'Soprano'),

-- 2025 Assignments
(27, 510, 'Idol'), (24, 510, 'Dancer'),
(4, 511, 'Dancer'),
(5, 512, 'Drummer'),
(15, 513, 'Conductor'),
(30, 514, 'Singer'),

-- 2026 Assignments
(13, 515, 'Keyboardist'),
(25, 516, 'Drum Major'),
(3, 517, 'Violinist'),
(26, 518, 'Singer'),
(2, 519, 'Dancer'),

-- 2027 Assignments
(5, 520, 'Guitarist'),
(29, 521, 'Soul Diva'),
(1, 522, 'DJ'),
(24, 523, 'Choir Lead'),
(30, 524, 'Banjo Player'),

-- 2028 Assignments
(25, 525, 'Bass Player'),
(28, 526, 'Producer'),
(21, 527, 'Bassist'),
(22, 528, 'Trumpet'),
(23, 529, 'Vocalist'),

-- 2029 Assignments
(29, 530, 'Choir Director'),
(19, 531, 'Sound Eng'),
(27, 532, 'Dancer'),
(6, 533, 'Harpist'),
(24, 534, 'Singer'),

-- 2030 Assignments
(4, 535, 'Hologram'),
(1, 536, 'Coder'),
(25, 537, 'Conductor'),
(3, 538, 'Pianist'),
(27, 539, 'Anthem Singer');

-- =============================================
-- PARTNER EXPANSION: THE "ENTOURAGE" PACK
-- Ensuring every actor has 6+ partners
-- IDs 1000+
-- =============================================

INSERT INTO partner_personnel (partner_id, name, service_type, personnel_id, contact_hire_date, contact_expiration_date, contract_amount, contact_info) VALUES 

-- =============================================
-- TEAM FOR ACTOR ID 1 (Leonardo DiC.)
-- =============================================
(1000, 'Goldman Legal', 'Legal', 1, '2023-01-01', '2026-01-01', 75000.00, 'Attorney: Saul G.'),
(1001, 'Summit Management', 'Manager', 1, '2023-01-01', '2026-01-01', 150000.00, 'Mgr: Rick'),
(1002, 'Prime Security', 'Security', 1, '2023-01-01', '2026-01-01', 200000.00, 'Head: Frank'),
(1003, 'Elite PR', 'Publicist', 1, '2023-01-01', '2026-01-01', 90000.00, 'Rep: Amanda'),
(1004, 'Global Finances', 'Accounting', 1, '2023-01-01', '2026-01-01', 50000.00, 'CPA: John'),
(1005, 'Social Buzz', 'Social Media', 1, '2023-01-01', '2026-01-01', 40000.00, 'Content: Sarah'),

-- =============================================
-- TEAM FOR ACTOR ID 2 (Meryl Str.)
-- =============================================
(1006, 'Goldman Legal', 'Legal', 2, '2023-01-01', '2026-01-01', 80000.00, 'Attorney: Kim'),
(1007, 'Iconic Mgmt', 'Manager', 2, '2023-01-01', '2026-01-01', 140000.00, 'Mgr: Stan'),
(1008, 'SafeGuard', 'Security', 2, '2023-01-01', '2026-01-01', 100000.00, 'Head: Bill'),
(1009, 'Star Press', 'Publicist', 2, '2023-01-01', '2026-01-01', 95000.00, 'Rep: Jen'),
(1010, 'Wealth Partners', 'Accounting', 2, '2023-01-01', '2026-01-01', 55000.00, 'CPA: Mike'),
(1011, 'Vocal Coaches Inc', 'Coach', 2, '2023-01-01', '2026-01-01', 30000.00, 'Coach: Al'),

-- =============================================
-- TEAM FOR ACTOR ID 3 (Tom Han.)
-- =============================================
(1012, 'Hanks Legal Team', 'Legal', 3, '2023-01-01', '2026-01-01', 70000.00, 'Attorney: Bob'),
(1013, 'Playtone Mgmt', 'Manager', 3, '2023-01-01', '2026-01-01', 160000.00, 'Mgr: Gary'),
(1014, 'Island Security', 'Security', 3, '2023-01-01', '2026-01-01', 120000.00, 'Head: Wilson'),
(1015, 'Friendly PR', 'Publicist', 3, '2023-01-01', '2026-01-01', 85000.00, 'Rep: Rita'),
(1016, 'Top Tier Acct', 'Accounting', 3, '2023-01-01', '2026-01-01', 45000.00, 'CPA: Larry'),
(1017, 'Typewriter Repair', 'Consultant', 3, '2023-01-01', '2026-01-01', 10000.00, 'Tech: Joe'),

-- =============================================
-- TEAM FOR ACTOR ID 4 (Scarlett Jo.)
-- =============================================
(1018, 'Avengers Legal', 'Legal', 4, '2023-01-01', '2026-01-01', 90000.00, 'Attorney: Matt'),
(1019, 'Black Widow Mgmt', 'Manager', 4, '2023-01-01', '2026-01-01', 180000.00, 'Mgr: Colin'),
(1020, 'Shield Security', 'Security', 4, '2023-01-01', '2026-01-01', 250000.00, 'Head: Nick'),
(1021, 'Red Carpet PR', 'Publicist', 4, '2023-01-01', '2026-01-01', 100000.00, 'Rep: Nat'),
(1022, 'Money Wise', 'Accounting', 4, '2023-01-01', '2026-01-01', 60000.00, 'CPA: Pepper'),
(1023, 'Stunt Trainers', 'Coach', 4, '2023-01-01', '2026-01-01', 50000.00, 'Trainer: Yelena'),

-- =============================================
-- TEAM FOR ACTOR ID 5 (Brad P.)
-- =============================================
(1024, 'Fight Club Legal', 'Legal', 5, '2023-01-01', '2026-01-01', 75000.00, 'Attorney: Tyler'),
(1025, 'Plan B Mgmt', 'Manager', 5, '2023-01-01', '2026-01-01', 155000.00, 'Mgr: Dede'),
(1026, 'Hollywood Guard', 'Security', 5, '2023-01-01', '2026-01-01', 180000.00, 'Head: Rusty'),
(1027, 'Cool PR', 'Publicist', 5, '2023-01-01', '2026-01-01', 92000.00, 'Rep: George'),
(1028, 'Asset Mgmt', 'Accounting', 5, '2023-01-01', '2026-01-01', 52000.00, 'CPA: Saul'),
(1029, 'Architecture Cons', 'Consultant', 5, '2023-01-01', '2026-01-01', 20000.00, 'Arch: Frank'),

-- =============================================
-- TEAM FOR ACTOR ID 6 (Jennifer Law.)
-- =============================================
(1030, 'District Legal', 'Legal', 6, '2023-01-01', '2026-01-01', 72000.00, 'Attorney: Haymitch'),
(1031, 'Mockingjay Mgmt', 'Manager', 6, '2023-01-01', '2026-01-01', 145000.00, 'Mgr: Effie'),
(1032, 'Arrow Security', 'Security', 6, '2023-01-01', '2026-01-01', 160000.00, 'Head: Gale'),
(1033, 'Relatable PR', 'Publicist', 6, '2023-01-01', '2026-01-01', 88000.00, 'Rep: Cinna'),
(1034, 'Capital Finance', 'Accounting', 6, '2023-01-01', '2026-01-01', 48000.00, 'CPA: Plutarch'),
(1035, 'Dior Stylist', 'Stylist', 6, '2023-01-01', '2026-01-01', 60000.00, 'Stylist: Raf'),

-- =============================================
-- TEAM FOR ACTOR ID 21 (Robert Den.)
-- =============================================
(1036, 'NY Legal', 'Legal', 21, '2023-01-01', '2025-01-01', 85000.00, 'Attorney: Marty'),
(1037, 'Taxi Mgmt', 'Manager', 21, '2023-01-01', '2025-01-01', 130000.00, 'Mgr: Travis'),
(1038, 'Tribeca Security', 'Security', 21, '2023-01-01', '2025-01-01', 150000.00, 'Head: Jimmy'),
(1039, 'Method PR', 'Publicist', 21, '2023-01-01', '2025-01-01', 95000.00, 'Rep: Vito'),
(1040, 'Old School Acct', 'Accounting', 21, '2023-01-01', '2025-01-01', 50000.00, 'CPA: Sam'),
(1041, 'Driver', 'Transport', 21, '2023-01-01', '2025-01-01', 40000.00, 'Driver: Paul'),

-- =============================================
-- TEAM FOR ACTOR ID 24 (Emma Sto.)
-- =============================================
(1042, 'LaLa Legal', 'Legal', 24, '2023-01-01', '2027-01-01', 80000.00, 'Attorney: Seb'),
(1043, 'Stone Mgmt', 'Manager', 24, '2023-01-01', '2027-01-01', 160000.00, 'Mgr: Mia'),
(1044, 'City Security', 'Security', 24, '2023-01-01', '2027-01-01', 140000.00, 'Head: Keith'),
(1045, 'Easy PR', 'Publicist', 24, '2023-01-01', '2027-01-01', 90000.00, 'Rep: Olive'),
(1046, 'Sunshine Acct', 'Accounting', 24, '2023-01-01', '2027-01-01', 55000.00, 'CPA: Cruella'),
(1047, 'Dance Coach', 'Coach', 24, '2023-01-01', '2027-01-01', 35000.00, 'Coach: Ryan'),

-- =============================================
-- TEAM FOR ACTOR ID 25 (Chris Hem.)
-- =============================================
(1048, 'Asgard Legal', 'Legal', 25, '2023-01-01', '2025-01-01', 82000.00, 'Attorney: Loki'),
(1049, 'Thunder Mgmt', 'Manager', 25, '2023-01-01', '2025-01-01', 170000.00, 'Mgr: Odin'),
(1050, 'Viking Security', 'Security', 25, '2023-01-01', '2025-01-01', 200000.00, 'Head: Heimdall'),
(1051, 'Worthy PR', 'Publicist', 25, '2023-01-01', '2025-01-01', 95000.00, 'Rep: Jane'),
(1052, 'Golden Acct', 'Accounting', 25, '2023-01-01', '2025-01-01', 58000.00, 'CPA: Frigga'),
(1053, 'Fitness Trainer', 'Coach', 25, '2023-01-01', '2025-01-01', 60000.00, 'Trainer: Luke'),

-- =============================================
-- TEAM FOR ACTOR ID 27 (Zendaya)
-- =============================================
(1054, 'Dune Legal', 'Legal', 27, '2023-01-01', '2027-01-01', 88000.00, 'Attorney: Paul'),
(1055, 'Euphoria Mgmt', 'Manager', 27, '2023-01-01', '2027-01-01', 190000.00, 'Mgr: Rue'),
(1056, 'Spider Security', 'Security', 27, '2023-01-01', '2027-01-01', 220000.00, 'Head: Happy'),
(1057, 'GenZ PR', 'Publicist', 27, '2023-01-01', '2027-01-01', 110000.00, 'Rep: MJ'),
(1058, 'Fashion Acct', 'Accounting', 27, '2023-01-01', '2027-01-01', 65000.00, 'CPA: Law'),
(1059, 'Image Architect', 'Stylist', 27, '2023-01-01', '2027-01-01', 150000.00, 'Stylist: Roach'),

-- =============================================
-- TEAM FOR ACTOR ID 28 (Timothee C.)
-- =============================================
(1060, 'Chalamet Legal', 'Legal', 28, '2023-01-01', '2027-01-01', 80000.00, 'Attorney: Elio'),
(1061, 'Wonka Mgmt', 'Manager', 28, '2023-01-01', '2027-01-01', 160000.00, 'Mgr: Willy'),
(1062, 'Desert Security', 'Security', 28, '2023-01-01', '2027-01-01', 180000.00, 'Head: Stilgar'),
(1063, 'Peach PR', 'Publicist', 28, '2023-01-01', '2027-01-01', 95000.00, 'Rep: Oliver'),
(1064, 'Cocoa Acct', 'Accounting', 28, '2023-01-01', '2027-01-01', 55000.00, 'CPA: Oompa'),
(1065, 'French Coach', 'Coach', 28, '2023-01-01', '2027-01-01', 30000.00, 'Coach: Laurie'),

-- =============================================
-- GENERIC TEAMS FOR REMAINING ACTORS (IDs 7, 8, 22, 23, 26, 29, 30, 31, 32)
-- Applying a standard pack to ensure >6 constraint
-- =============================================

-- Actor 7
(1066, 'Basic Legal', 'Legal', 7, '2024-01-01', '2025-01-01', 10000.00, 'Legal Aid'),
(1067, 'Self Mgmt', 'Manager', 7, '2024-01-01', '2025-01-01', 0.00, 'Self'),
(1068, 'Rent-A-Guard', 'Security', 7, '2024-01-01', '2025-01-01', 5000.00, 'Guard A'),
(1069, 'Freelance PR', 'Publicist', 7, '2024-01-01', '2025-01-01', 2000.00, 'Free'),
(1070, 'TurboTax', 'Accounting', 7, '2024-01-01', '2025-01-01', 100.00, 'App'),
(1071, 'Mom', 'Assistant', 7, '2024-01-01', '2025-01-01', 0.00, 'Mom'),

-- Actor 8
(1072, 'Basic Legal', 'Legal', 8, '2024-01-01', '2025-01-01', 10000.00, 'Legal Aid'),
(1073, 'Self Mgmt', 'Manager', 8, '2024-01-01', '2025-01-01', 0.00, 'Self'),
(1074, 'Rent-A-Guard', 'Security', 8, '2024-01-01', '2025-01-01', 5000.00, 'Guard B'),
(1075, 'Freelance PR', 'Publicist', 8, '2024-01-01', '2025-01-01', 2000.00, 'Free'),
(1076, 'TurboTax', 'Accounting', 8, '2024-01-01', '2025-01-01', 100.00, 'App'),
(1077, 'Dad', 'Assistant', 8, '2024-01-01', '2025-01-01', 0.00, 'Dad'),

-- Actor 22 (Al Pacino)
(1078, 'Legend Legal', 'Legal', 22, '2023-01-01', '2025-01-01', 90000.00, 'Firm A'),
(1079, 'Legacy Mgmt', 'Manager', 22, '2023-01-01', '2025-01-01', 150000.00, 'Firm B'),
(1080, 'Mob Security', 'Security', 22, '2023-01-01', '2025-01-01', 120000.00, 'Guard C'),
(1081, 'Classic PR', 'Publicist', 22, '2023-01-01', '2025-01-01', 80000.00, 'Rep C'),
(1082, 'Vault Acct', 'Accounting', 22, '2023-01-01', '2025-01-01', 60000.00, 'Bank A'),
(1083, 'Voice Coach', 'Coach', 22, '2023-01-01', '2025-01-01', 40000.00, 'Loud'),

-- Actor 23 (Julia Roberts)
(1084, 'Smile Legal', 'Legal', 23, '2023-01-01', '2026-01-01', 95000.00, 'Firm D'),
(1085, 'Pretty Mgmt', 'Manager', 23, '2023-01-01', '2026-01-01', 180000.00, 'Firm E'),
(1086, 'Safe House', 'Security', 23, '2023-01-01', '2026-01-01', 130000.00, 'Guard D'),
(1087, 'America PR', 'Publicist', 23, '2023-01-01', '2026-01-01', 100000.00, 'Rep D'),
(1088, 'Big Bucks', 'Accounting', 23, '2023-01-01', '2026-01-01', 70000.00, 'Bank B'),
(1089, 'Nanny', 'Assistant', 23, '2023-01-01', '2026-01-01', 50000.00, 'Mary'),

-- Actor 26 (Ryan Gosling)
(1090, 'Ken Legal', 'Legal', 26, '2023-01-01', '2026-01-01', 85000.00, 'Firm F'),
(1091, 'Drive Mgmt', 'Manager', 26, '2023-01-01', '2026-01-01', 160000.00, 'Firm G'),
(1092, 'Stunt Guard', 'Security', 26, '2023-01-01', '2026-01-01', 110000.00, 'Guard E'),
(1093, 'Hey Girl PR', 'Publicist', 26, '2023-01-01', '2026-01-01', 92000.00, 'Rep E'),
(1094, 'Canadian Bank', 'Accounting', 26, '2023-01-01', '2026-01-01', 55000.00, 'Bank C'),
(1095, 'Piano Teacher', 'Coach', 26, '2023-01-01', '2026-01-01', 30000.00, 'Teach'),

-- Actor 29 (Viola Davis)
(1096, 'EGOT Legal', 'Legal', 29, '2023-01-01', '2025-01-01', 92000.00, 'Firm H'),
(1097, 'Power Mgmt', 'Manager', 29, '2023-01-01', '2025-01-01', 175000.00, 'Firm I'),
(1098, 'Woman King Sec', 'Security', 29, '2023-01-01', '2025-01-01', 140000.00, 'Guard F'),
(1099, 'Prestige PR', 'Publicist', 29, '2023-01-01', '2025-01-01', 98000.00, 'Rep F'),
(1100, 'Trust Acct', 'Accounting', 29, '2023-01-01', '2025-01-01', 65000.00, 'Bank D'),
(1101, 'Wig Stylist', 'Stylist', 29, '2023-01-01', '2025-01-01', 40000.00, 'Hair'),

-- Actor 30 (Denzel Washington)
(1102, 'Equalizer Legal', 'Legal', 30, '2023-01-01', '2025-01-01', 99000.00, 'Firm J'),
(1103, 'Titan Mgmt', 'Manager', 30, '2023-01-01', '2025-01-01', 200000.00, 'Firm K'),
(1104, 'Man on Fire Sec', 'Security', 30, '2023-01-01', '2025-01-01', 180000.00, 'Creasy'),
(1105, 'Goat PR', 'Publicist', 30, '2023-01-01', '2025-01-01', 105000.00, 'Rep G'),
(1106, 'Empire Acct', 'Accounting', 30, '2023-01-01', '2025-01-01', 80000.00, 'Bank E'),
(1107, 'Pastor', 'Consultant', 30, '2023-01-01', '2025-01-01', 0.00, 'Rev'),

-- Actor 31 (Extra)
(1108, 'LegalZoom', 'Legal', 31, '2024-01-01', '2024-12-31', 500.00, 'Online'),
(1109, 'None', 'Manager', 31, '2024-01-01', '2024-12-31', 0.00, 'None'),
(1110, 'Door Lock', 'Security', 31, '2024-01-01', '2024-12-31', 50.00, 'Key'),
(1111, 'Instagram', 'Publicist', 31, '2024-01-01', '2024-12-31', 0.00, 'Meta'),
(1112, 'Excel', 'Accounting', 31, '2024-01-01', '2024-12-31', 0.00, 'MS'),
(1113, 'Cat', 'Assistant', 31, '2024-01-01', '2024-12-31', 0.00, 'Pet'),

-- Actor 32 (Extra)
(1114, 'LegalZoom', 'Legal', 32, '2024-01-01', '2024-12-31', 500.00, 'Online'),
(1115, 'None', 'Manager', 32, '2024-01-01', '2024-12-31', 0.00, 'None'),
(1116, 'Door Lock', 'Security', 32, '2024-01-01', '2024-12-31', 50.00, 'Key'),
(1117, 'TikTok', 'Publicist', 32, '2024-01-01', '2024-12-31', 0.00, 'Byte'),
(1118, 'Excel', 'Accounting', 32, '2024-01-01', '2024-12-31', 0.00, 'MS'),
(1119, 'Dog', 'Assistant', 32, '2024-01-01', '2024-12-31', 0.00, 'Pet');

-- =============================================
-- 2025 OVERLAP PACK (Busy Days)
-- Creating clusters of 5+ simultaneous activities per month
-- IDs 2500+
-- =============================================

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES

-- JAN 15, 2025: Winter Gala Planning Crunch (Overlap Count: ~7 with existing data)
(2500, 50, 3, '2025-01-15 09:00:00', '2025-01-15 17:00:00', 'Logistics Mtg', 'Office'),
(2501, 50, 4, '2025-01-15 09:00:00', '2025-01-15 17:00:00', 'Promo Shoot', 'Studio A'),
(2502, 50, 5, '2025-01-15 09:00:00', '2025-01-15 17:00:00', 'Rehearsal', 'Hall B'),
(2503, 50, 6, '2025-01-15 09:00:00', '2025-01-15 17:00:00', 'Voiceover', 'Booth'),
(2504, 50, 11, '2025-01-15 09:00:00', '2025-01-15 17:00:00', 'Costume Fit', 'Wardrobe'),

-- FEB 14, 2025: Fashion Week Chaos (Valentine's Gala)
(2505, 51, 1, '2025-02-14 18:00:00', '2025-02-14 23:00:00', 'VIP Guest', 'Ballroom'),
(2506, 51, 2, '2025-02-14 18:00:00', '2025-02-14 23:00:00', 'VIP Guest', 'Ballroom'),
(2507, 51, 3, '2025-02-14 18:00:00', '2025-02-14 23:00:00', 'Host', 'Stage'),
(2508, 51, 5, '2025-02-14 18:00:00', '2025-02-14 23:00:00', 'Security Detail', 'Entrance'),
(2509, 51, 10, '2025-02-14 16:00:00', '2025-02-14 20:00:00', 'Makeup Rush', 'Backstage'),

-- MAR 15, 2025: Spring Play Tech Rehearsal
(2510, 52, 1, '2025-03-15 08:00:00', '2025-03-15 18:00:00', 'Set Construction', 'Stage'),
(2511, 52, 2, '2025-03-15 08:00:00', '2025-03-15 18:00:00', 'Light Rigging', 'Stage'),
(2512, 52, 3, '2025-03-15 08:00:00', '2025-03-15 18:00:00', 'Sound Check', 'Booth'),
(2513, 52, 4, '2025-03-15 09:00:00', '2025-03-15 17:00:00', 'Props Check', 'Backstage'),
(2514, 52, 5, '2025-03-15 09:00:00', '2025-03-15 17:00:00', 'Safety Drill', 'Stage'),

-- APR 15, 2025: Comedy Tour Mid-Run
(2515, 53, 25, '2025-04-15 19:00:00', '2025-04-15 22:00:00', 'Opener', 'Stage'),
(2516, 53, 26, '2025-04-15 19:00:00', '2025-04-15 22:00:00', 'Guest Spot', 'Stage'),
(2517, 53, 27, '2025-04-15 19:00:00', '2025-04-15 22:00:00', 'Audience Cam', 'House'),
(2518, 53, 28, '2025-04-15 18:00:00', '2025-04-15 23:00:00', 'Merch Sales', 'Lobby'),
(2519, 53, 29, '2025-04-15 18:00:00', '2025-04-15 23:00:00', 'Ticket Box', 'Lobby'),

-- MAY 15, 2025: Indie Film Production Peak
(2520, 54, 21, '2025-05-15 07:00:00', '2025-05-15 19:00:00', 'Extra', 'Set'),
(2521, 54, 22, '2025-05-15 07:00:00', '2025-05-15 19:00:00', 'Extra', 'Set'),
(2522, 54, 23, '2025-05-15 07:00:00', '2025-05-15 19:00:00', 'Stand-in', 'Set'),
(2523, 54, 24, '2025-05-15 07:00:00', '2025-05-15 19:00:00', 'Stand-in', 'Set'),
(2524, 54, 30, '2025-05-15 08:00:00', '2025-05-15 18:00:00', 'Catering', 'Tent'),

-- JUN 15, 2025: Blockbuster Big Stunt Day
(2525, 55, 11, '2025-06-15 06:00:00', '2025-06-15 18:00:00', 'Costume Repair', 'Trailer'),
(2526, 55, 12, '2025-06-15 06:00:00', '2025-06-15 18:00:00', 'Costume Repair', 'Trailer'),
(2527, 55, 13, '2025-06-15 06:00:00', '2025-06-15 20:00:00', '2nd Unit Dir', 'Rooftop B'),
(2528, 55, 14, '2025-06-15 06:00:00', '2025-06-15 20:00:00', 'Camera Op', 'Rooftop B'),
(2529, 55, 15, '2025-06-15 06:00:00', '2025-06-15 20:00:00', 'Producer Watch', 'Video Village'),

-- JUL 15, 2025: Music Festival Setup
(2530, 56, 6, '2025-07-15 08:00:00', '2025-07-15 18:00:00', 'Stage Hands', 'Park'),
(2531, 56, 7, '2025-07-15 08:00:00', '2025-07-15 18:00:00', 'Stage Hands', 'Park'),
(2532, 56, 8, '2025-07-15 08:00:00', '2025-07-15 18:00:00', 'Stage Hands', 'Park'),
(2533, 56, 9, '2025-07-15 08:00:00', '2025-07-15 18:00:00', 'Vendor Setup', 'Park'),
(2534, 56, 10, '2025-07-15 08:00:00', '2025-07-15 18:00:00', 'Vendor Setup', 'Park'),

-- AUG 15, 2025: Action Sequel Filming
(2535, 57, 31, '2025-08-15 05:00:00', '2025-08-15 17:00:00', 'Background', 'Field'),
(2536, 57, 32, '2025-08-15 05:00:00', '2025-08-15 17:00:00', 'Background', 'Field'),
(2537, 57, 33, '2025-08-15 05:00:00', '2025-08-15 17:00:00', 'Makeup Assist', 'Tent'),
(2538, 57, 34, '2025-08-15 05:00:00', '2025-08-15 17:00:00', 'Costume Assist', 'Tent'),
(2539, 57, 35, '2025-08-15 06:00:00', '2025-08-15 18:00:00', 'Grip', 'Field'),

-- SEP 15, 2025: Documentary Editing Crunch
(2540, 58, 16, '2025-09-15 09:00:00', '2025-09-15 21:00:00', 'Producer', 'Edit Bay'),
(2541, 58, 17, '2025-09-15 09:00:00', '2025-09-15 21:00:00', 'Editor', 'Edit Bay'),
(2542, 58, 18, '2025-09-15 09:00:00', '2025-09-15 21:00:00', 'Colorist', 'Lab'),
(2543, 58, 19, '2025-09-15 09:00:00', '2025-09-15 21:00:00', 'Sound Mix', 'Lab'),
(2544, 58, 20, '2025-09-15 09:00:00', '2025-09-15 21:00:00', 'Graphics', 'Lab'),

-- OCT 31, 2025: Halloween Horror Premiere (Everyone attends)
(2545, 59, 1, '2025-10-31 18:00:00', '2025-10-31 23:00:00', 'Red Carpet', 'Theater'),
(2546, 59, 2, '2025-10-31 18:00:00', '2025-10-31 23:00:00', 'Red Carpet', 'Theater'),
(2547, 59, 3, '2025-10-31 18:00:00', '2025-10-31 23:00:00', 'Red Carpet', 'Theater'),
(2548, 59, 4, '2025-10-31 18:00:00', '2025-10-31 23:00:00', 'Red Carpet', 'Theater'),
(2549, 59, 5, '2025-10-31 18:00:00', '2025-10-31 23:00:00', 'Red Carpet', 'Theater'),

-- NOV 20, 2025: Awards Show (Huge Crew Overlap)
(2550, 60, 6, '2025-11-20 14:00:00', '2025-11-20 23:00:00', 'Nominee', 'Seat 1'),
(2551, 60, 7, '2025-11-20 14:00:00', '2025-11-20 23:00:00', 'Seat Filler', 'Seat 2'),
(2552, 60, 8, '2025-11-20 14:00:00', '2025-11-20 23:00:00', 'Seat Filler', 'Seat 3'),
(2553, 60, 21, '2025-11-20 16:00:00', '2025-11-20 23:00:00', 'Press', 'Red Carpet'),
(2554, 60, 22, '2025-11-20 16:00:00', '2025-11-20 23:00:00', 'Press', 'Red Carpet'),

-- DEC 24, 2025: Holiday Charity Event
(2555, 61, 10, '2025-12-24 10:00:00', '2025-12-24 14:00:00', 'Elf', 'Hospital'),
(2556, 61, 11, '2025-12-24 10:00:00', '2025-12-24 14:00:00', 'Helper', 'Hospital'),
(2557, 61, 12, '2025-12-24 10:00:00', '2025-12-24 14:00:00', 'Singer', 'Hospital'),
(2558, 61, 13, '2025-12-24 10:00:00', '2025-12-24 14:00:00', 'Director', 'Hospital'),
(2559, 61, 14, '2025-12-24 10:00:00', '2025-12-24 14:00:00', 'Camera', 'Hospital');

-- =============================================
-- 2025 WEEK-LONG CRUNCH TIMES
-- 4 separate weeks where 5+ people are booked 24/7 (or close to it)
-- IDs 4000+
-- =============================================

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES

-- =========================================================
-- WEEK 1: MARCH 10-16, 2025 (Spring Play "Tech Week")
-- Personnel ID: 29, 30, 35, 11, 19
-- =========================================================
(4001, 52, 29, '2025-03-10 08:00:00', '2025-03-16 23:00:00', 'Tech Week Lockdown', 'Theater Main'),
(4002, 52, 30, '2025-03-10 08:00:00', '2025-03-16 23:00:00', 'Tech Week Lockdown', 'Theater Main'),
(4003, 52, 35, '2025-03-10 07:00:00', '2025-03-16 23:59:00', 'Director Oversight', 'Theater Main'),
(4004, 52, 11, '2025-03-10 06:00:00', '2025-03-16 20:00:00', 'Costume Parade', 'Wardrobe'),
(4005, 52, 19, '2025-03-10 08:00:00', '2025-03-16 23:00:00', 'Lighting Cueing', 'Tech Booth'),

-- =========================================================
-- WEEK 2: JUNE 16-22, 2025 (Blockbuster "Island Shoot")
-- Personnel ID: 25, 5, 4, 37, 39
-- =========================================================
(4006, 55, 25, '2025-06-16 05:00:00', '2025-06-22 20:00:00', 'Location Shoot', 'Hawaii'),
(4007, 55, 5,  '2025-06-16 05:00:00', '2025-06-22 20:00:00', 'Location Stunts', 'Hawaii'),
(4008, 55, 4,  '2025-06-16 05:00:00', '2025-06-22 20:00:00', 'Location Shoot', 'Hawaii'),
(4009, 55, 37, '2025-06-16 05:00:00', '2025-06-22 22:00:00', 'Principal Photography', 'Hawaii'),
(4010, 55, 39, '2025-06-16 04:00:00', '2025-06-22 18:00:00', 'Volcano FX Setup', 'Hawaii'),

-- =========================================================
-- WEEK 3: SEPT 08-14, 2025 (Music "Writing Camp")
-- Personnel ID: 1, 15, 24, 20, 17
-- =========================================================
(4011, 514, 1,  '2025-09-08 10:00:00', '2025-09-14 23:59:00', 'Studio Lockdown', 'Remote Cabin'),
(4012, 514, 15, '2025-09-08 10:00:00', '2025-09-14 23:59:00', 'Exec Production', 'Remote Cabin'),
(4013, 514, 24, '2025-09-08 10:00:00', '2025-09-14 23:59:00', 'Vocal Tracking', 'Remote Cabin'),
(4014, 514, 20, '2025-09-08 08:00:00', '2025-09-14 23:59:00', 'Sound Engineering', 'Remote Cabin'),
(4015, 514, 17, '2025-09-08 08:00:00', '2025-09-14 18:00:00', 'Camp Logistics', 'Remote Cabin'),

-- =========================================================
-- WEEK 4: DEC 01-07, 2025 (Holiday Special "Marathon")
-- Personnel ID: 3, 2, 9, 10, 18
-- =========================================================
(4016, 61, 3,  '2025-12-01 07:00:00', '2025-12-07 22:00:00', 'Filming Special', 'Studio 8H'),
(4017, 61, 2,  '2025-12-01 07:00:00', '2025-12-07 22:00:00', 'Filming Special', 'Studio 8H'),
(4018, 61, 9,  '2025-12-01 05:00:00', '2025-12-07 20:00:00', 'Makeup Chair', 'Dressing Rooms'),
(4019, 61, 10, '2025-12-01 05:00:00', '2025-12-07 20:00:00', 'Prosthetics', 'Dressing Rooms'),
(4020, 61, 18, '2025-12-01 06:00:00', '2025-12-07 23:00:00', 'Logistics Coord', 'Control Room');

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES 
-- DEC 2025 (Current Month Activities)
(2560, 59, 37, '2025-12-01 09:00:00', '2025-12-05 17:00:00', 'Final Color Grade', 'Post Lab'),
(2561, 59, 1, '2025-12-08 10:00:00', '2025-12-08 13:00:00', 'ADR Session', 'Studio C'),
(2562, 60, 24, '2025-12-10 18:00:00', '2025-12-10 23:00:00', 'Award Ceremony', 'Royal Opera House'),
(2563, 60, 40, '2025-12-10 16:00:00', '2025-12-11 02:00:00', 'Security Detail', 'Royal Opera House'),

-- JAN 2026 (Q1 2026 - Targeting Production 55: Action Sequel & 511: Latin Rhythms Release)
(2564, 55, 25, '2026-01-15 07:00:00', '2026-01-15 19:00:00', 'Stunt Filming', 'Warehouse District'),
(2565, 55, 35, '2026-01-15 06:00:00', '2026-01-15 20:00:00', 'Directing', 'Warehouse District'),
(2566, 55, 4, '2026-01-16 09:00:00', '2026-01-16 17:00:00', 'Costume Fitting', 'Wardrobe'),
(2567, 511, 2, '2026-01-20 10:00:00', '2026-01-20 16:00:00', 'Music Video Shoot', 'Studio 54'),
(2568, 511, 23, '2026-01-21 11:00:00', '2026-01-21 15:00:00', 'Photo Shoot', 'Studio 54'),

-- FEB 2026 (Q1 2026 - Targeting Production 26: Space Opera)
(2569, 26, 28, '2026-02-01 08:00:00', '2026-02-01 18:00:00', 'Green Screen Shoot', 'Studio 54'),
(2570, 26, 27, '2026-02-01 08:00:00', '2026-02-01 18:00:00', 'Green Screen Shoot', 'Studio 54'),
(2571, 26, 34, '2026-02-02 09:00:00', '2026-02-02 17:00:00', 'Costume Maintenance', 'Studio 54'),

-- MAR 2026 (Q1 2026 - Targeting Production 25: Super Hero Team)
(2572, 25, 15, '2026-03-10 10:00:00', '2026-03-10 12:00:00', 'Investor Pitch', 'Office'),
(2573, 25, 25, '2026-03-20 07:00:00', '2026-03-20 17:00:00', 'Action Scene Blocking', 'Downtown Arena');

-- =============================================
-- ADDING 50 NEW PERSONNEL (IDs 41 - 90)
-- =============================================
INSERT INTO personnel (personnel_id, name, email, phone, personnel_type, contract_hire_date, contract_expiration_date) VALUES 
(41, 'Maxine Taylor', 'max@studio.com', '555-1041', 'Actor', '2025-01-01', '2027-01-01'),
(42, 'Leo Rodriguez', 'leo.r@film.com', '555-1042', 'Actor', '2025-02-01', '2027-02-01'),
(43, 'Chloe Evans', 'chloe@actress.com', '555-1043', 'Actress', '2025-03-01', '2027-03-01'),
(44, 'Sam Walker', 'sam@talent.com', '555-1044', 'Actor', '2025-04-01', '2027-04-01'),
(45, 'Isabel Chen', 'isabel@tv.com', '555-1045', 'Actress', '2025-05-01', '2027-05-01'),
(46, 'Ethan Bell', 'ethan@films.com', '555-1046', 'Actor', '2025-06-01', '2028-06-01'),
(47, 'Ava Miller', 'ava@media.com', '555-1047', 'Actress', '2025-07-01', '2028-07-01'),
(48, 'Noah King', 'noah@set.com', '555-1048', 'Actor', '2025-08-01', '2028-08-01'),
(49, 'Mia Harris', 'mia@cinema.com', '555-1049', 'Actress', '2025-09-01', '2028-09-01'),
(50, 'Liam Scott', 'liam@production.com', '555-1050', 'Actor', '2025-10-01', '2028-10-01'),
(51, 'Maya Baker', 'maya@artist.com', '555-1051', 'Actress', '2025-11-01', '2028-11-01'),
(52, 'Oscar Green', 'oscar@performance.com', '555-1052', 'Actor', '2025-12-01', '2028-12-01'),
(53, 'Piper Hall', 'piper@stage.com', '555-1053', 'Actress', '2025-12-15', '2028-12-15'),
(54, 'Quinn Clark', 'quinn@screen.com', '555-1054', 'Actor', '2025-12-20', '2028-12-20'),
(55, 'Ruby Day', 'ruby@show.com', '555-1055', 'Actress', '2025-12-25', '2028-12-25'),
(56, 'Sebastian Fox', 'seb@play.com', '555-1056', 'Actor', '2025-12-30', '2028-12-30'),
(57, 'Talia Gray', 'talia@film.com', '555-1057', 'Actress', '2026-01-05', '2029-01-05'),
(58, 'Victor Hunt', 'vic@set.com', '555-1058', 'Actor', '2026-01-10', '2029-01-10'),
(59, 'Willow Ivy', 'willow@act.com', '555-1059', 'Actress', '2026-01-15', '2029-01-15'),
(60, 'Xavier Jones', 'xav@scene.com', '555-1060', 'Actor', '2026-01-20', '2029-01-20'),
(61, 'Yara Kim', 'yara@camera.com', '555-1061', 'Actress', '2026-01-25', '2029-01-25'),
(62, 'Zane Lane', 'zane@sound.com', '555-1062', 'Actor', '2026-01-30', '2029-01-30'),
(63, 'Adam Moore', 'adam@light.com', '555-1063', 'Actor', '2026-02-05', '2029-02-05'),
(64, 'Bella Nash', 'bella@costume.com', '555-1064', 'Actress', '2026-02-10', '2029-02-10'),
(65, 'Caleb Olson', 'caleb@prop.com', '555-1065', 'Actor', '2026-02-15', '2029-02-15'),
(66, 'Dana Price', 'dana@stunt.com', '555-1066', 'Actress', '2026-02-20', '2029-02-20'),
(67, 'Elias Reed', 'elias@edit.com', '555-1067', 'Actor', '2026-02-25', '2029-02-25'),
(68, 'Fiona Stone', 'fiona@direct.com', '555-1068', 'Actress', '2026-03-01', '2029-03-01'),
(69, 'Gavin Troy', 'gavin@produce.com', '555-1069', 'Actor', '2026-03-05', '2029-03-05'),
(70, 'Hannah Vance', 'hannah@manage.com', '555-1070', 'Actress', '2026-03-10', '2029-03-10'),
(71, 'Isaac West', 'isaac@design.com', '555-1071', 'Actor', '2026-03-15', '2029-03-15'),
(72, 'Jada Young', 'jada@event.com', '555-1072', 'Actress', '2026-03-20', '2029-03-20'),
(73, 'Kyle Zimmer', 'kyle@media.com', '555-1073', 'Actor', '2026-03-25', '2029-03-25'),
(74, 'Lila Allen', 'lila@pr.com', '555-1074', 'Actress', '2026-03-30', '2029-03-30'),
(75, 'Mark Brown', 'mark@safe.com', '555-1075', 'Actor', '2025-01-01', '2027-01-01'),
(76, 'Nina Cook', 'nina@legal.com', '555-1076', 'Actress', '2025-02-01', '2027-02-01'),
(77, 'Owen Dale', 'owen@finance.com', '555-1077', 'Actor', '2025-03-01', '2027-03-01'),
(78, 'Phoebe Evans', 'phoebe@tech.com', '555-1078', 'Actress', '2025-04-01', '2027-04-01'),
(79, 'Quentin Finn', 'quent@art.com', '555-1079', 'Actor', '2025-05-01', '2027-05-01'),
(80, 'Rachel Gage', 'rach@music.com', '555-1080', 'Actress', '2025-06-01', '2028-06-01'),
(81, 'Steve Hill', 'steve@writer.com', '555-1081', 'Actor', '2025-07-01', '2028-07-01'),
(82, 'Tess Iyer', 'tess@design.com', '555-1082', 'Actress', '2025-08-01', '2028-08-01'),
(83, 'Uri Jackson', 'uri@promo.com', '555-1083', 'Actor', '2025-09-01', '2028-09-01'),
(84, 'Vicky Kent', 'vicky@sound.com', '555-1084', 'Actress', '2025-10-01', '2028-10-01'),
(85, 'Will Lowe', 'will@stunts.com', '555-1085', 'Actor', '2025-11-01', '2028-11-01'),
(86, 'Zara Morris', 'zara@costume.com', '555-1086', 'Actress', '2025-12-01', '2028-12-01'),
(87, 'Allen Nash', 'allen@makeup.com', '555-1087', 'Actor', '2025-12-15', '2028-12-15'),
(88, 'Beth Olson', 'beth@hair.com', '555-1088', 'Actress', '2025-12-20', '2028-12-20'),
(89, 'Carl Price', 'carl@stage.com', '555-1089', 'Actor', '2025-12-25', '2028-12-25'),
(90, 'Dora Quinn', 'dora@light.com', '555-1090', 'Actress', '2025-12-30', '2028-12-30');

-- ADD CORRESPONDING PERFORMERS
INSERT INTO performer (personnel_id, performance_type, agency) VALUES 
(41, 'Dramatic Actor', 'Agency 1'), (42, 'Action Star', 'Agency 2'), (43, 'Comedic Actress', 'Agency 3'),
(44, 'Voice Actor', 'Agency 4'), (45, 'TV Actress', 'Agency 5'), (46, 'Lead Actor', 'Agency 1'),
(47, 'Supporting Actress', 'Agency 2'), (48, 'Method Actor', 'Agency 3'), (49, 'Dancer/Actress', 'Agency 4'),
(50, 'Action Star', 'Agency 5'), (51, 'Lead Actress', 'Agency 1'), (52, 'Dramatic Actor', 'Agency 2'),
(53, 'Comedic Actress', 'Agency 3'), (54, 'Musical Performer', 'Agency 4'), (55, 'Action Star', 'Agency 5'),
(56, 'Dramatic Actor', 'Agency 1'), (57, 'Lead Actress', 'Agency 2'), (58, 'Supporting Actor', 'Agency 3'),
(59, 'Voice Actress', 'Agency 4'), (60, 'Action Star', 'Agency 5'), (61, 'Model/Actress', 'Agency 1'),
(62, 'Dramatic Actor', 'Agency 2'), (63, 'Comedic Actor', 'Agency 3'), (64, 'Dancer/Actress', 'Agency 4'),
(65, 'Lead Actor', 'Agency 5'), (66, 'Supporting Actress', 'Agency 1'), (67, 'Method Actor', 'Agency 2'),
(68, 'TV Actress', 'Agency 3'), (69, 'Action Star', 'Agency 4'), (70, 'Musical Performer', 'Agency 5');

-- =============================================
-- ADDING 50 NEW PRODUCTIONS (IDs 601 - 650)
-- =============================================
INSERT INTO production (production_id, title, production_type, contract_hire_date, contract_expiration_date, partner_id) VALUES 
-- DECEMBER 2025 (Current Month)
(601, 'Holiday Gala 2025', 'Event', '2025-10-01', '2025-12-25', 100), -- Catering
(602, 'New Year Sci-Fi Teaser', 'General', '2025-08-01', '2026-01-30', 101), -- Transport
(603, 'Winter Charity Concert', 'Event', '2025-11-01', '2025-12-31', 103), -- Sound
(604, 'Gothic Horror Shoot', 'General', '2025-07-01', '2026-02-15', 106), -- Wardrobe
(605, 'Year End Review Show', 'Event', '2025-10-01', '2025-12-30', 102), -- Lighting

-- JANUARY 2026 (Q1)
(606, 'Cyberpunk Movie 2', 'General', '2025-09-01', '2026-03-30', 104), -- FX
(607, 'Historical Drama Pilot', 'General', '2025-10-01', '2026-04-30', 108), -- Construction
(608, 'Comedy Tour Launch', 'Event', '2025-11-01', '2026-01-31', 100), -- Catering
(609, 'Art Film Reshoots', 'General', '2025-12-01', '2026-02-28', 103), -- Sound
(610, 'Winter Fashion Show', 'Event', '2025-11-01', '2026-01-31', 102), -- Lighting
(611, 'Kids Fantasy Show', 'General', '2025-06-01', '2026-05-30', 106), -- Wardrobe
(612, 'Crime Thriller Scene', 'General', '2025-09-01', '2026-03-30', 101), -- Transport

-- FEBRUARY 2026 (Q1)
(613, 'Superhero Montage', 'General', '2025-11-01', '2026-03-31', 104), -- FX
(614, 'Romantic Web Series', 'General', '2025-12-01', '2026-04-30', 108), -- Construction
(615, 'TED-style Talk Event', 'Event', '2026-01-01', '2026-02-28', 100), -- Catering
(616, 'Indie Music Video', 'General', '2026-01-01', '2026-03-15', 103), -- Sound
(617, 'The Oscars Viewing Party', 'Event', '2026-01-15', '2026-03-22', 102), -- Lighting
(618, 'Western Desert Shoot', 'General', '2025-08-01', '2026-04-01', 106), -- Wardrobe

-- MARCH 2026 (Q1)
(619, 'Post-Apocalyptic Series', 'General', '2025-10-01', '2026-05-30', 101), -- Transport
(620, 'Spring Dance Festival', 'Event', '2026-01-01', '2026-03-31', 107), -- Musicians
(621, 'Horror Film 3 Trailer', 'General', '2025-12-01', '2026-04-30', 104), -- FX
(622, 'Casting Call Event', 'Event', '2026-02-01', '2026-03-31', 100), -- Catering
(623, 'Sci-Fi Soundtrack Mix', 'General', '2026-01-01', '2026-04-30', 103), -- Sound
(624, 'Behind the Scenes Doc', 'General', '2025-12-01', '2026-05-30', 108), -- Construction

-- EXTRA FILLER PRODUCTIONS (625-650)
(625, 'Medieval Fantasy 5', 'General', '2026-03-01', '2027-03-01', 106), (626, 'Space Exploration Log', 'General', '2026-03-01', '2027-03-01', 101),
(627, 'Silent Short Film', 'General', '2026-03-01', '2027-03-01', 102), (628, 'Road Trip Reality', 'General', '2026-03-01', '2027-03-01', 100),
(629, 'Vampire Diaries Reboot', 'General', '2026-03-01', '2027-03-01', 104), (630, 'Historical Romance', 'General', '2026-03-01', '2027-03-01', 108),
(631, 'Nature Documentary 2', 'General', '2026-03-01', '2027-03-01', 103), (632, 'Standup Special', 'General', '2026-03-01', '2027-03-01', 100),
(633, 'Political Thriller', 'General', '2026-03-01', '2027-03-01', 101), (634, 'Cult Classic Remake', 'General', '2026-03-01', '2027-03-01', 106),
(635, 'Time Travel Movie', 'General', '2026-03-01', '2027-03-01', 102), (636, 'Family Sitcom Pilot', 'General', '2026-03-01', '2027-03-01', 103),
(637, 'Disaster Movie', 'General', '2026-03-01', '2027-03-01', 104), (638, 'Fantasy Series', 'General', '2026-03-01', '2027-03-01', 108),
(639, 'Musical Drama', 'General', '2026-03-01', '2027-03-01', 107), (640, 'Spy Action Movie', 'General', '2026-03-01', '2027-03-01', 105),
(641, 'International Film Showcase', 'Event', '2026-03-01', '2026-04-30', 102), (642, 'Charity Marathon', 'Event', '2026-03-01', '2026-04-30', 100),
(643, 'Esports Tournament Finals', 'Event', '2026-03-01', '2026-04-30', 103), (644, 'Wine Tasting & Auction', 'Event', '2026-03-01', '2026-04-30', 107),
(645, 'Tech Product Launch', 'Event', '2026-03-01', '2026-04-30', 104), (646, 'Art Exhibition Opening', 'Event', '2026-03-01', '2026-04-30', 106),
(647, 'Global Leadership Summit', 'Event', '2026-03-01', '2026-04-30', 101), (648, 'Food Truck Festival', 'Event', '2026-03-01', '2026-04-30', 108),
(649, 'Standup Comedy Night', 'Event', '2026-03-01', '2026-04-30', 103), (650, 'University Graduation', 'Event', '2026-03-01', '2026-04-30', 100);

-- 2.1 NEW GENERAL PRODUCTIONS
INSERT INTO generalproduction (production_id, genre, plan_release_quarter, plan_release_year) VALUES 
(602, 'Sci-Fi', 2, 2026), (604, 'Horror', 2, 2026), (606, 'Action', 3, 2026), (607, 'History', 4, 2026),
(609, 'Art House', 2, 2026), (611, 'Fantasy', 3, 2026), (612, 'Thriller', 3, 2026), (613, 'Action', 4, 2026),
(614, 'Romance', 4, 2026), (616, 'Music', 2, 2026), (618, 'Western', 4, 2026), (619, 'Sci-Fi', 1, 2027),
(621, 'Horror', 1, 2027), (623, 'Music', 2, 2027), (624, 'Documentary', 3, 2026),
(625, 'Fantasy', 1, 2027), (626, 'Sci-Fi', 2, 2027), (627, 'Art House', 3, 2027), (628, 'Reality', 4, 2027),
(629, 'Horror', 1, 2028), (630, 'Romance', 2, 2028), (631, 'Documentary', 3, 2028), (632, 'Comedy', 4, 2028),
(633, 'Thriller', 1, 2029), (634, 'Action', 2, 2029), (635, 'Sci-Fi', 3, 2029), (636, 'Comedy', 4, 2029),
(637, 'Action', 1, 2030), (638, 'Fantasy', 2, 2030), (639, 'Music', 3, 2030), (640, 'Spy Action Movie', 4, 2030);

-- 2.2 NEW EVENT PRODUCTIONS
INSERT INTO eventproduction (production_id, event_type, location, audience_capacity) VALUES 
(601, 'Gala', 'Grand Theater', 1500), (603, 'Concert', 'Concert Hall', 1000), (605, 'Talk Show', 'Studio 54', 100),
(608, 'Comedy Show', 'Underground Club', 300), (610, 'Runway', 'Convention Center', 5000),
(615, 'Conference', 'Convention Center', 2000), (617, 'Gala', 'Grand Theater', 1000), 
(620, 'Festival', 'City Park Amphitheater', 4000), (622, 'Casting', 'Studio 54', 50),
(641, 'Festival', 'Grand Theater', 1500), (642, 'Sport', 'City Park Amphitheater', 5000),
(643, 'Tournament', 'Downtown Arena', 10000), (644, 'Gala', 'Concert Hall', 500),
(645, 'Expo', 'Convention Center', 3000), (646, 'Exhibition', 'Studio 54', 200),
(647, 'Conference', 'Convention Center', 8000), (648, 'Festival', 'City Park Amphitheater', 5000),
(649, 'Comedy Show', 'Underground Club', 250), (650, 'Ceremony', 'Grand Theater', 1800);

-- =============================================
-- PERSONNEL ASSIGNMENTS (12 people per P601-P650)
-- =============================================
INSERT INTO personnelassignment (personnel_id, production_id, role_title) VALUES
-- P601: Holiday Gala 2025 (Event) - DEC 2025
(41, 601, 'Host'), (42, 601, 'Performer'), (43, 601, 'Hostess'), (44, 601, 'Narrator'), (45, 601, 'Singer'), (46, 601, 'Dancer'), (47, 601, 'Event Manager'), (48, 601, 'Security Chief'), (13, 601, 'Creative Director'), (15, 601, 'Executive Producer'), (17, 601, 'Catering Manager'), (19, 601, 'Lighting Tech'),

-- P602: New Year Sci-Fi Teaser (General) - DEC 2025
(50, 602, 'Lead Actor'), (51, 602, 'Lead Actress'), (52, 602, 'Supporting Actor'), (53, 602, 'Supporting Actress'), (54, 602, 'Stunt Double'), (48, 602, 'Director'), (15, 602, 'Producer'), (9, 602, 'Makeup Artist'), (11, 602, 'Costumer'), (13, 602, 'Second Unit Director'), (18, 602, 'Logistics Manager'), (20, 602, 'Sound Designer'),

-- P603: Winter Charity Concert (Event) - DEC 2025
(55, 603, 'Lead Singer'), (56, 603, 'Guitarist'), (57, 603, 'Host'), (58, 603, 'Security'), (59, 603, 'Backstage Manager'), (60, 603, 'Stage Hand'), (61, 603, 'Vocal Coach'), (62, 603, 'Sound Engineer'), (13, 603, 'Event Organizer'), (15, 603, 'Fundraising Lead'), (17, 603, 'Catering'), (19, 603, 'Lighting'),

-- P604: Gothic Horror Shoot (General) - DEC 2025
(63, 604, 'Lead Actor'), (64, 604, 'Lead Actress'), (65, 604, 'Creature Performer'), (66, 604, 'Stunt Coordinator'), (67, 604, 'Director'), (68, 604, 'Producer'), (69, 604, 'Writer'), (70, 604, 'Costumer'), (13, 604, 'VFX Supervisor'), (15, 604, 'Executive Producer'), (9, 604, 'SFX Makeup'), (20, 604, 'Sound Recordist'),

-- P605: Year End Review Show (Event) - DEC 2025
(71, 605, 'Host'), (72, 605, 'Co-Host'), (73, 605, 'Guest 1'), (74, 605, 'Guest 2'), (75, 605, 'Stage Manager'), (76, 605, 'Teleprompter Op'), (77, 605, 'Lighting Designer'), (78, 605, 'Technical Director'), (13, 605, 'Show Runner'), (15, 605, 'Segment Producer'), (17, 605, 'Catering'), (18, 605, 'Transport'),

-- P606: Cyberpunk Movie 2 (General) - JAN 2026
(41, 606, 'Lead Actor'), (42, 606, 'Supporting Actor'), (43, 606, 'Lead Actress'), (44, 606, 'Stunt Double'), (45, 606, 'Director'), (46, 606, 'Producer'), (47, 606, 'VFX Artist'), (48, 606, 'Costumer'), (13, 606, 'Action Director'), (15, 606, 'Executive Producer'), (9, 606, 'Makeup'), (19, 606, 'Lighting'),

-- P607: Historical Drama Pilot (General) - JAN 2026
(50, 607, 'Lead Actor'), (51, 607, 'Supporting Actress'), (52, 607, 'Director'), (53, 607, 'Producer'), (54, 607, 'Set Designer'), (55, 607, 'Historical Consultant'), (56, 607, 'Costume Supervisor'), (57, 607, 'Makeup Artist'), (13, 607, 'Script Supervisor'), (15, 607, 'Financier'), (17, 607, 'Catering'), (20, 607, 'Sound'),

-- P608: Comedy Tour Launch (Event) - JAN 2026
(58, 608, 'Comedian 1'), (59, 608, 'Comedian 2'), (60, 608, 'Opener'), (61, 608, 'Tour Manager'), (62, 608, 'Security'), (63, 608, 'Sound Tech'), (64, 608, 'Lighting Tech'), (65, 608, 'Stage Manager'), (13, 608, 'Creative Director'), (15, 608, 'Promoter'), (18, 608, 'Logistics'), (19, 608, 'Electrician'),

-- P609: Art Film Reshoots (General) - JAN 2026
(66, 609, 'Lead Actress'), (67, 609, 'Lead Actor'), (68, 609, 'Director'), (69, 609, 'Producer'), (70, 609, 'D.O.P.'), (71, 609, 'Gaffer'), (72, 609, 'Grip'), (73, 609, 'Sound Mixer'), (13, 609, 'Executive Producer'), (15, 609, 'Line Producer'), (9, 609, 'Makeup'), (11, 609, 'Costume'),

-- P610: Winter Fashion Show (Event) - JAN 2026
(74, 610, 'Model 1'), (75, 610, 'Model 2'), (76, 610, 'Stylist'), (77, 610, 'Designer'), (78, 610, 'Backstage Mgr'), (79, 610, 'Lighting Tech'), (80, 610, 'DJ'), (81, 610, 'Security'), (13, 610, 'Event Planner'), (15, 610, 'Sponsorship Mgr'), (17, 610, 'Catering'), (20, 610, 'Sound'),

-- P611: Kids Fantasy Show (General) - FEB 2026
(82, 611, 'Lead Actor'), (83, 611, 'Lead Actress'), (84, 611, 'Puppeteer'), (85, 611, 'Voice Actor'), (86, 611, 'Director'), (87, 611, 'Producer'), (88, 611, 'Costume Designer'), (89, 611, 'Set Builder'), (13, 611, 'Showrunner'), (15, 611, 'Executive Producer'), (9, 611, 'Makeup'), (19, 611, 'Lighting'),

-- P612: Crime Thriller Scene (General) - FEB 2026
(90, 612, 'Lead Actor'), (41, 612, 'Supporting Actor'), (42, 612, 'Director'), (43, 612, 'Producer'), (44, 612, 'Camera Op'), (45, 612, 'Editor'), (46, 612, 'Transport Mgr'), (47, 612, 'Security'), (13, 612, 'Stunt Coordinator'), (15, 612, 'Line Producer'), (17, 612, 'Catering'), (20, 612, 'Sound'),

-- P613: Superhero Montage (General) - FEB 2026
(48, 613, 'Hero 1'), (49, 613, 'Hero 2'), (50, 613, 'Director'), (51, 613, 'Producer'), (52, 613, 'VFX Artist'), (53, 613, 'Stunt Double'), (54, 613, 'Costumer'), (55, 613, 'SFX Lead'), (13, 613, 'Action Director'), (15, 613, 'Executive Producer'), (9, 613, 'Makeup'), (11, 613, 'Costume'),

-- P614: Romantic Web Series (General) - MAR 2026
(56, 614, 'Lead Actor'), (57, 614, 'Lead Actress'), (58, 614, 'Director'), (59, 614, 'Producer'), (60, 614, 'Writer'), (61, 614, 'Editor'), (62, 614, 'Set Builder'), (63, 614, 'Gaffer'), (13, 614, 'Executive Producer'), (15, 614, 'Marketing Lead'), (18, 614, 'Transport'), (19, 614, 'Lighting'),

-- P615: TED-style Talk Event (Event) - FEB 2026
(64, 615, 'Speaker 1'), (65, 615, 'Speaker 2'), (66, 615, 'Host'), (67, 615, 'Event Planner'), (68, 615, 'Security'), (69, 615, 'A/V Tech'), (70, 615, 'Lighting Tech'), (71, 615, 'Catering Manager'), (13, 615, 'Creative Director'), (15, 615, 'Sponsorship Mgr'), (17, 615, 'Catering'), (20, 615, 'Sound'),

-- P616: Indie Music Video (General) - MAR 2026
(72, 616, 'Artist'), (73, 616, 'Backup Dancer'), (74, 616, 'Director'), (75, 616, 'Producer'), (76, 616, 'D.O.P.'), (77, 616, 'Choreographer'), (78, 616, 'Costumer'), (79, 616, 'Sound Engineer'), (13, 616, 'Executive Producer'), (15, 616, 'Line Producer'), (9, 616, 'Makeup'), (18, 616, 'Transport'),

-- P617: The Oscars Viewing Party (Event) - MAR 2026
(80, 617, 'Host'), (81, 617, 'Co-Host'), (82, 617, 'Guest 1'), (83, 617, 'Guest 2'), (84, 617, 'Event Manager'), (85, 617, 'Security'), (86, 617, 'Lighting Tech'), (87, 617, 'Catering Manager'), (13, 617, 'Creative Director'), (15, 617, 'VIP Liaison'), (17, 617, 'Catering'), (19, 617, 'Lighting'),

-- P618: Western Desert Shoot (General) - MAR 2026
(88, 618, 'Lead Actor'), (89, 618, 'Lead Actress'), (90, 618, 'Director'), (41, 618, 'Producer'), (42, 618, 'Stunt Coordinator'), (43, 618, 'Costumer'), (44, 618, 'Armorer'), (45, 618, 'Set Builder'), (13, 618, 'Executive Producer'), (15, 618, 'Line Producer'), (9, 618, 'Makeup'), (20, 618, 'Sound'),

-- P619: Post-Apocalyptic Series (General) - MAR 2026
(46, 619, 'Lead Actor'), (47, 619, 'Lead Actress'), (48, 619, 'Director'), (49, 619, 'Producer'), (50, 619, 'VFX Supervisor'), (51, 619, 'Costumer'), (52, 619, 'Makeup'), (53, 619, 'Transport Mgr'), (13, 619, 'Executive Producer'), (15, 619, 'Line Producer'), (18, 619, 'Transport'), (19, 619, 'Lighting'),

-- P620: Spring Dance Festival (Event) - MAR 2026
(54, 620, 'Dancer 1'), (55, 620, 'Dancer 2'), (56, 620, 'Choreographer'), (57, 620, 'Stage Manager'), (58, 620, 'Security'), (59, 620, 'Sound Tech'), (60, 620, 'Lighting Tech'), (61, 620, 'Ticket Master'), (13, 620, 'Event Organizer'), (15, 620, 'Sponsorship Mgr'), (17, 620, 'Catering'), (20, 620, 'Sound'),

-- Assignments for P621-P650 (Ensuring 10+ personnel)
(62, 621, 'Director'), (63, 621, 'Producer'), (64, 621, 'Lead Actress'), (65, 621, 'Stuntman'), (66, 621, 'Costumer'), (67, 621, 'Makeup'), (68, 621, 'Sound'), (69, 621, 'Light'), (70, 621, 'Transport'), (71, 621, 'Catering'), (72, 621, 'Security'), (73, 621, 'VFX Artist'),
(74, 622, 'Casting Director'), (75, 622, 'Producer'), (76, 622, 'Manager'), (77, 622, 'Interviewer'), (78, 622, 'A/V Tech'), (79, 622, 'Security'), (80, 622, 'Host'), (81, 622, 'Assistant'), (82, 622, 'Makeup'), (83, 622, 'Costume'), (84, 622, 'Sound'), (85, 622, 'Lighting'),
(86, 623, 'Sound Mixer'), (87, 623, 'Producer'), (88, 623, 'Engineer'), (89, 623, 'Composer'), (90, 623, 'Artist'), (41, 623, 'Manager'), (42, 623, 'Assistant'), (43, 623, 'Publicist'), (44, 623, 'Legal'), (45, 623, 'Finance'), (46, 623, 'Transport'), (47, 623, 'Security'),
(48, 624, 'Director'), (49, 624, 'Producer'), (50, 624, 'Camera Op'), (51, 624, 'Editor'), (52, 624, 'Narrator'), (53, 624, 'Sound'), (54, 624, 'Transport'), (55, 624, 'Security'), (56, 624, 'Costume'), (57, 624, 'Makeup'), (58, 624, 'Catering'), (59, 624, 'Lighting'),
(60, 625, 'Lead Actor'), (61, 625, 'Lead Actress'), (62, 625, 'Director'), (63, 625, 'Producer'), (64, 625, 'Costumer'), (65, 625, 'Makeup'), (66, 625, 'VFX'), (67, 625, 'Stunt'), (68, 625, 'Sound'), (69, 625, 'Light'), (70, 625, 'Transport'), (71, 625, 'Catering'),
(72, 626, 'Lead Actor'), (73, 626, 'Director'), (74, 626, 'Producer'), (75, 626, 'VFX'), (76, 626, 'Costume'), (77, 626, 'Makeup'), (78, 626, 'Sound'), (79, 626, 'Light'), (80, 626, 'Transport'), (81, 626, 'Catering'), (82, 626, 'Security'), (83, 626, 'Writer'),
(84, 627, 'Lead Actor'), (85, 627, 'Lead Actress'), (86, 627, 'Director'), (87, 627, 'Producer'), (88, 627, 'Costume'), (89, 627, 'Makeup'), (90, 627, 'Sound'), (41, 627, 'Light'), (42, 627, 'Transport'), (43, 627, 'Catering'), (44, 627, 'Security'), (45, 627, 'Editor'),
(46, 628, 'Host'), (47, 628, 'Producer'), (48, 628, 'Camera Op'), (49, 628, 'Sound'), (50, 628, 'Transport'), (51, 628, 'Security'), (52, 628, 'Makeup'), (53, 628, 'Costume'), (54, 628, 'Gaffer'), (55, 628, 'Grip'), (56, 628, 'Driver'), (57, 628, 'Assistant'),
(58, 629, 'Lead Actor'), (59, 629, 'Lead Actress'), (60, 629, 'Director'), (61, 629, 'Producer'), (62, 629, 'SFX'), (63, 629, 'Costume'), (64, 629, 'Makeup'), (65, 629, 'Sound'), (66, 629, 'Light'), (67, 629, 'Transport'), (68, 629, 'Catering'), (69, 629, 'Security'),
(70, 630, 'Lead Actor'), (71, 630, 'Lead Actress'), (72, 630, 'Director'), (73, 630, 'Producer'), (74, 630, 'Costume'), (75, 630, 'Makeup'), (76, 630, 'Sound'), (77, 630, 'Light'), (78, 630, 'Transport'), (79, 630, 'Catering'), (80, 630, 'Security'), (81, 630, 'Writer'),
(82, 631, 'Narrator'), (83, 631, 'Director'), (84, 631, 'Producer'), (85, 631, 'Camera Op'), (86, 631, 'Sound'), (87, 631, 'Editor'), (88, 631, 'Transport'), (89, 631, 'Security'), (90, 631, 'Researcher'), (41, 631, 'Assistant'), (42, 631, 'Gaffer'), (43, 631, 'Grip'),
(44, 632, 'Comedian'), (45, 632, 'Director'), (46, 632, 'Producer'), (47, 632, 'Sound'), (48, 632, 'Light'), (49, 632, 'Stage Manager'), (50, 632, 'Security'), (51, 632, 'Catering'), (52, 632, 'Transport'), (53, 632, 'Makeup'), (54, 632, 'Costume'), (55, 632, 'Writer'),
(56, 633, 'Lead Actor'), (57, 633, 'Lead Actress'), (58, 633, 'Director'), (59, 633, 'Producer'), (60, 633, 'Security'), (61, 633, 'Transport'), (62, 633, 'Sound'), (63, 633, 'Light'), (64, 633, 'Costume'), (65, 633, 'Makeup'), (66, 633, 'Writer'), (67, 633, 'Advisor'),
(68, 634, 'Lead Actor'), (69, 634, 'Lead Actress'), (70, 634, 'Director'), (71, 634, 'Producer'), (72, 634, 'Stunt'), (73, 634, 'VFX'), (74, 634, 'Costume'), (75, 634, 'Makeup'), (76, 634, 'Sound'), (77, 634, 'Light'), (78, 634, 'Transport'), (79, 634, 'Security'),
(80, 635, 'Lead Actor'), (81, 635, 'Lead Actress'), (82, 635, 'Director'), (83, 635, 'Producer'), (84, 635, 'VFX'), (85, 635, 'Costume'), (86, 635, 'Makeup'), (87, 635, 'Sound'), (88, 635, 'Light'), (89, 635, 'Transport'), (90, 635, 'Security'), (41, 635, 'Writer'),
(42, 636, 'Lead Actor'), (43, 636, 'Lead Actress'), (44, 636, 'Director'), (45, 636, 'Producer'), (46, 636, 'Writer'), (47, 636, 'Costume'), (48, 636, 'Makeup'), (49, 636, 'Sound'), (50, 636, 'Light'), (51, 636, 'Catering'), (52, 636, 'Transport'), (53, 636, 'Security'),
(54, 637, 'Lead Actor'), (55, 637, 'Lead Actress'), (56, 637, 'Director'), (57, 637, 'Producer'), (58, 637, 'VFX'), (59, 637, 'Stunt'), (60, 637, 'Costume'), (61, 637, 'Makeup'), (62, 637, 'Sound'), (63, 637, 'Light'), (64, 637, 'Transport'), (65, 637, 'Security'),
(66, 638, 'Lead Actor'), (67, 638, 'Lead Actress'), (68, 638, 'Director'), (69, 638, 'Producer'), (70, 638, 'Costume'), (71, 638, 'Makeup'), (72, 638, 'VFX'), (73, 638, 'Sound'), (74, 638, 'Light'), (75, 638, 'Transport'), (76, 638, 'Security'), (77, 638, 'Writer'),
(78, 639, 'Lead Singer'), (79, 639, 'Dancer'), (80, 639, 'Director'), (81, 639, 'Producer'), (82, 639, 'Costume'), (83, 639, 'Makeup'), (84, 639, 'Sound'), (85, 639, 'Light'), (86, 639, 'Transport'), (87, 639, 'Catering'), (88, 639, 'Security'), (89, 639, 'Choreographer'),
(90, 640, 'Lead Actor'), (41, 640, 'Lead Actress'), (42, 640, 'Director'), (43, 640, 'Producer'), (44, 640, 'Stunt'), (45, 640, 'Armorer'), (46, 640, 'Costume'), (47, 640, 'Makeup'), (48, 640, 'Sound'), (49, 640, 'Light'), (50, 640, 'Transport'), (51, 640, 'Security'),
(52, 641, 'Event Manager'), (53, 641, 'Host'), (54, 641, 'Curator'), (55, 641, 'Security'), (56, 641, 'Catering'), (57, 641, 'Sound'), (58, 641, 'Light'), (59, 641, 'Transport'), (60, 641, 'Projectionist'), (61, 641, 'Publicist'), (62, 641, 'Assistant'), (63, 641, 'Director'),
(64, 642, 'Host'), (65, 642, 'Runner'), (66, 642, 'Security'), (67, 642, 'Medic'), (68, 642, 'Catering'), (69, 642, 'Sound'), (70, 642, 'Light'), (71, 642, 'Transport'), (72, 642, 'Volunteer Mgr'), (73, 642, 'Logistics'), (74, 642, 'Producer'), (75, 642, 'Director'),
(76, 643, 'Caster'), (77, 643, 'Commentator'), (78, 643, 'Security'), (79, 643, 'A/V Tech'), (80, 643, 'Lighting'), (81, 643, 'Sound'), (82, 643, 'Transport'), (83, 643, 'Catering'), (84, 643, 'Producer'), (85, 643, 'Director'), (86, 643, 'Technician'), (87, 643, 'Manager'),
(88, 644, 'Sommelier'), (89, 644, 'Auctioneer'), (90, 644, 'Host'), (41, 644, 'Catering'), (42, 644, 'Security'), (43, 644, 'Sound'), (44, 644, 'Light'), (45, 644, 'Transport'), (46, 644, 'Event Planner'), (47, 644, 'Assistant'), (48, 644, 'Producer'), (49, 644, 'Director'),
(50, 645, 'Speaker'), (51, 645, 'Host'), (52, 645, 'Security'), (53, 645, 'A/V Tech'), (54, 645, 'Lighting'), (55, 645, 'Sound'), (56, 645, 'Transport'), (57, 645, 'Catering'), (58, 645, 'Technician'), (59, 645, 'Producer'), (60, 645, 'Director'), (61, 645, 'Manager'),
(62, 646, 'Curator'), (63, 646, 'Artist'), (64, 646, 'Security'), (65, 646, 'Catering'), (66, 646, 'Sound'), (67, 646, 'Light'), (68, 646, 'Transport'), (69, 646, 'Host'), (70, 646, 'Event Planner'), (71, 646, 'Assistant'), (72, 646, 'Producer'), (73, 646, 'Director'),
(74, 647, 'Speaker'), (75, 647, 'Host'), (76, 647, 'Security'), (77, 647, 'A/V Tech'), (78, 647, 'Lighting'), (79, 647, 'Sound'), (80, 647, 'Transport'), (81, 647, 'Catering'), (82, 647, 'Technician'), (83, 647, 'Producer'), (84, 647, 'Director'), (85, 647, 'Manager'),
(86, 648, 'Vendor'), (87, 648, 'Host'), (88, 648, 'Security'), (89, 648, 'Catering'), (90, 648, 'Sound'), (41, 648, 'Light'), (42, 648, 'Transport'), (43, 648, 'Vendor Mgr'), (44, 648, 'Assistant'), (45, 648, 'Producer'), (46, 648, 'Director'), (47, 648, 'Manager'),
(48, 649, 'Comedian'), (49, 649, 'Host'), (50, 649, 'Security'), (51, 649, 'Sound'), (52, 649, 'Light'), (53, 649, 'Catering'), (54, 649, 'Transport'), (55, 649, 'Stage Manager'), (56, 649, 'Producer'), (57, 649, 'Director'), (58, 649, 'Writer'), (59, 649, 'Assistant'),
(60, 650, 'Speaker'), (61, 650, 'Host'), (62, 650, 'Security'), (63, 650, 'Catering'), (64, 650, 'Sound'), (65, 650, 'Light'), (66, 650, 'Transport'), (67, 650, 'Event Planner'), (68, 650, 'Assistant'), (69, 650, 'Producer'), (70, 650, 'Director'), (71, 650, 'Technician');

-- =============================================
-- PRODUCTION SCHEDULES (IDs 3000 - 3040)
-- Focused on DECEMBER 2025 (Current) and Q1 2026
-- =============================================
INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES 
-- DECEMBER 2025 (Current Month)
(3000, 601, 41, '2025-12-20 18:00:00', '2025-12-20 23:00:00', 'Dress Rehearsal', 'Grand Theater'),
(3001, 601, 47, '2025-12-24 10:00:00', '2025-12-24 16:00:00', 'Setup & Final Prep', 'Grand Theater'),
(3002, 602, 50, '2025-12-18 07:00:00', '2025-12-18 19:00:00', 'Green Screen Shoot', 'Studio 54'),
(3003, 602, 51, '2025-12-19 09:00:00', '2025-12-19 12:00:00', 'ADR Session', 'Post Lab'),
(3004, 603, 55, '2025-12-28 17:00:00', '2025-12-28 23:00:00', 'Sound Check & Concert', 'Concert Hall'),
(3005, 604, 63, '2025-12-16 08:00:00', '2025-12-16 18:00:00', 'Scene 1: Mansion Interior', 'Location'),
(3006, 604, 64, '2025-12-17 07:00:00', '2025-12-17 19:00:00', 'Scene 2: Forest Shoot', 'Location'),
(3007, 605, 71, '2025-12-30 14:00:00', '2025-12-30 20:00:00', 'Live Taping', 'Studio 54'),

-- JANUARY 2026 (Q1)
(3008, 606, 41, '2026-01-10 06:00:00', '2026-01-10 18:00:00', 'Explosion Stunt', 'Warehouse District'),
(3009, 606, 43, '2026-01-11 09:00:00', '2026-01-11 17:00:00', 'Close-ups & Dialogue', 'Studio 54'),
(3010, 607, 50, '2026-01-20 07:00:00', '2026-01-20 19:00:00', 'Battle Scene Filming', 'Sunset Ranch'),
(3011, 607, 51, '2026-01-21 09:00:00', '2026-01-21 17:00:00', 'Interior Dialogue', 'Location'),
(3012, 608, 58, '2026-01-29 18:00:00', '2026-01-29 23:00:00', 'Performance 1', 'Underground Club'),
(3013, 609, 66, '2026-01-15 10:00:00', '2026-01-15 14:00:00', 'Pickup Shots', 'Location'),
(3014, 610, 74, '2026-01-28 16:00:00', '2026-01-28 22:00:00', 'Runway Show', 'Convention Center'),

-- FEBRUARY 2026 (Q1)
(3015, 611, 82, '2026-02-10 08:00:00', '2026-02-10 16:00:00', 'Puppet Rehearsal', 'Studio 54'),
(3016, 611, 83, '2026-02-11 09:00:00', '2026-02-11 17:00:00', 'Vocal Recording', 'Sound Lab'),
(3017, 612, 90, '2026-02-20 20:00:00', '2026-02-21 04:00:00', 'Night Shoot: Car Scene', 'Warehouse District'),
(3018, 613, 48, '2026-02-28 07:00:00', '2026-02-28 17:00:00', 'Flying Sequence Shoot', 'Studio 54'),
(3019, 614, 57, '2026-02-14 10:00:00', '2026-02-14 15:00:00', 'Valentine Scene', 'Location'),
(3020, 615, 64, '2026-02-25 09:00:00', '2026-02-25 18:00:00', 'Main Conference', 'Convention Center'),

-- MARCH 2026 (Q1)
(3021, 616, 72, '2026-03-05 13:00:00', '2026-03-05 23:00:00', 'Video Shoot', 'Location'),
(3022, 617, 80, '2026-03-22 17:00:00', '2026-03-22 23:59:00', 'Live Event Hosting', 'Grand Theater'),
(3023, 618, 88, '2026-03-10 06:00:00', '2026-03-10 18:00:00', 'Final Duel Scene', 'Sunset Ranch'),
(3024, 619, 46, '2026-03-28 08:00:00', '2026-03-28 18:00:00', 'Location Shoot', 'Warehouse District'),
(3025, 620, 54, '2026-03-20 15:00:00', '2026-03-20 23:00:00', 'Performance Night 1', 'Amphitheater'),

-- Scheduling for remaining productions (621-650) in Q1 2026 or later for data variety
(3026, 621, 62, '2026-02-15 10:00:00', '2026-02-15 16:00:00', 'Trailer Shoot', 'Studio 54'),
(3027, 622, 74, '2026-03-15 09:00:00', '2026-03-15 17:00:00', 'Casting Interviews', 'Studio 54'),
(3028, 623, 86, '2026-03-20 10:00:00', '2026-03-20 18:00:00', 'Mixing Session', 'Sound Lab'),
(3029, 624, 48, '2026-03-25 08:00:00', '2026-03-25 17:00:00', 'Interview Day', 'Office'),
(3030, 625, 60, '2026-04-10 07:00:00', '2026-04-10 19:00:00', 'Action Sequence', 'Location'),
(3031, 626, 72, '2026-04-20 09:00:00', '2026-04-20 17:00:00', 'Zero-G Shoot', 'Studio 54'),
(3032, 627, 84, '2026-05-01 10:00:00', '2026-05-01 16:00:00', 'Street Scene', 'Location'),
(3033, 628, 46, '2026-05-10 09:00:00', '2026-05-10 17:00:00', 'Road Trip Start', 'Location'),
(3034, 629, 58, '2026-06-01 20:00:00', '2026-06-02 04:00:00', 'Night Feeding Scene', 'Location'),
(3035, 630, 70, '2026-06-15 08:00:00', '2026-06-15 18:00:00', 'Period Piece Shoot', 'Location'),
(3036, 631, 82, '2026-07-01 07:00:00', '2026-07-01 19:00:00', 'Wildlife Filming', 'Location'),
(3037, 632, 44, '2026-07-10 20:00:00', '2026-07-10 23:00:00', 'Standup Taping', 'Underground Club'),
(3038, 633, 56, '2026-08-01 08:00:00', '2026-08-01 18:00:00', 'Office Scene', 'Location'),
(3039, 634, 68, '2026-08-15 09:00:00', '2026-08-15 17:00:00', 'Fight Choreography', 'Studio 54'),
(3040, 635, 80, '2026-09-01 08:00:00', '2026-09-01 18:00:00', 'Future City Scene', 'Location');

-- =============================================
-- PRODUCTION EXPENSES (IDs 500 - 700)
-- =============================================
INSERT INTO productionexpense (expense_id, production_id, expense_type, amount, expense_date, description) VALUES 
-- P601-P620: 4 expenses each
(500, 601, 'Catering', 15000.00, '2025-12-24', 'Holiday meal service'), (501, 601, 'Lighting', 5000.00, '2025-12-24', 'Uplighting and stage lighting'), (502, 601, 'Security', 8000.00, '2025-12-25', 'Event security staff'), (503, 601, 'Venue Rental', 25000.00, '2025-12-26', 'Grand Theater Rental Fee'),
(504, 602, 'VFX Cost', 50000.00, '2025-12-30', 'Visual effects outsourcing'), (505, 602, 'Equipment Rental', 12000.00, '2025-12-28', 'Camera and lens package'), (506, 602, 'Transport', 7000.00, '2026-01-05', 'Equipment transport'), (507, 602, 'Personnel Salary', 80000.00, '2026-01-10', 'Actor salaries for shoot'),
(508, 603, 'Artist Fees', 30000.00, '2025-12-30', 'Headliner fee'), (509, 603, 'Sound Eq Rental', 10000.00, '2025-12-31', 'PA system rental'), (510, 603, 'Promotion', 5000.00, '2025-12-01', 'Online ads'), (511, 603, 'Venue Rental', 18000.00, '2026-01-02', 'Concert Hall Fee'),
(512, 604, 'Costume Budget', 20000.00, '2026-01-15', 'Historical costumes'), (513, 604, 'Set Construction', 15000.00, '2026-01-05', 'Interior set build'), (514, 604, 'SFX Makeup', 10000.00, '2026-01-20', 'Special effects makeup'), (515, 604, 'Location Fees', 7000.00, '2026-01-25', 'Mansion rental'),
(516, 605, 'Lighting Rig', 6000.00, '2025-12-28', 'Studio lighting rental'), (517, 605, 'Catering', 4000.00, '2025-12-30', 'Refreshments for crew'), (518, 605, 'Host Fee', 15000.00, '2026-01-05', 'Main host compensation'), (519, 605, 'Studio Rental', 5000.00, '2025-12-31', 'Studio 54 rental'),
(520, 606, 'Pyrotechnics', 25000.00, '2026-01-20', 'Explosion effects'), (521, 606, 'VFX Software', 10000.00, '2026-01-01', 'License fee'), (522, 606, 'Stunt Team', 30000.00, '2026-01-25', 'Stunt performers salary'), (523, 606, 'Location Fees', 15000.00, '2026-01-30', 'City permits'),
(524, 607, 'Costumes', 45000.00, '2026-01-10', 'Period wardrobe purchase'), (525, 607, 'Set Building', 25000.00, '2026-01-05', 'Castle exterior build'), (526, 607, 'Catering', 8000.00, '2026-01-15', 'On-set meals'), (527, 607, 'Transport', 5000.00, '2026-01-20', 'Horse transport'),
(528, 608, 'Comedian Fees', 40000.00, '2026-01-31', 'Performer fees'), (529, 608, 'Sound System', 3000.00, '2026-01-25', 'PA system rental'), (530, 608, 'Security', 4000.00, '2026-01-28', 'Venue security'), (531, 608, 'Venue Rental', 5000.00, '2026-01-30', 'Underground Club rental'),
(532, 609, 'Film Stock', 15000.00, '2026-02-05', '35mm film purchase'), (533, 609, 'Gaffer Salary', 6000.00, '2026-02-10', 'Lighting lead compensation'), (534, 609, 'Location Fee', 3000.00, '2026-02-15', 'Apartment rental'), (535, 609, 'Sound Mix', 8000.00, '2026-02-28', 'Post-production audio mixing'),
(536, 610, 'Model Fees', 35000.00, '2026-01-31', 'Model compensation'), (537, 610, 'Runway Build', 12000.00, '2026-01-25', 'Temporary stage construction'), (538, 610, 'Lighting', 8000.00, '2026-01-28', 'Specialty lighting'), (539, 610, 'Venue Rental', 20000.00, '2026-02-01', 'Convention Center rental'),
(540, 611, 'Puppet Cost', 10000.00, '2026-02-15', 'Custom puppet construction'), (541, 611, 'Costumes', 15000.00, '2026-02-10', 'Child actor costumes'), (542, 611, 'Set Design', 20000.00, '2026-02-01', 'Fantasy backdrop build'), (543, 611, 'Transport', 4000.00, '2026-02-20', 'Prop delivery'),
(544, 612, 'Security', 7000.00, '2026-02-25', 'Traffic control and perimeter security'), (545, 612, 'Stunt Double Fee', 10000.00, '2026-02-20', 'Performer fee'), (546, 612, 'Catering', 5000.00, '2026-02-25', 'Late-night shoot catering'), (547, 612, 'Location Fee', 8000.00, '2026-02-28', 'Abandoned factory rental'),
(548, 613, 'VFX Budget', 60000.00, '2026-03-05', 'Post-production CGI'), (549, 613, 'Pyrotechnics', 15000.00, '2026-02-28', 'Fire effects'), (550, 613, 'Costumes', 25000.00, '2026-02-15', 'Armored suit material'), (551, 613, 'Stunt Coordinator', 12000.00, '2026-03-01', 'Coordinator salary'),
(552, 614, 'Location Fee', 4000.00, '2026-03-10', 'Coffee shop rental'), (553, 614, 'Writer Salary', 10000.00, '2026-03-15', 'Script writer fee'), (554, 614, 'Transport', 2000.00, '2026-03-20', 'Small van rental'), (555, 614, 'Marketing', 5000.00, '2026-03-25', 'Instagram promotion'),
(556, 615, 'Speaker Fees', 50000.00, '2026-02-28', 'Keynote speaker fees'), (557, 615, 'AV Tech', 10000.00, '2026-02-27', 'Screen and projector rental'), (558, 615, 'Catering', 12000.00, '2026-02-26', 'Breakfast and lunch service'), (559, 615, 'Venue Rental', 15000.00, '2026-03-01', 'Convention Center hall rental'),
(560, 616, 'Artist Fee', 8000.00, '2026-03-20', 'Musician compensation'), (561, 616, 'Location Fee', 3000.00, '2026-03-15', 'Skate park rental'), (562, 616, 'DOP Fee', 5000.00, '2026-03-25', 'Cinematographer salary'), (563, 616, 'Sound Mixing', 4000.00, '2026-03-30', 'Post-production audio'),
(564, 617, 'Decorations', 8000.00, '2026-03-20', 'Red carpet and floral arrangements'), (565, 617, 'Catering', 20000.00, '2026-03-25', 'VIP four-course dinner'), (566, 617, 'Security', 10000.00, '2026-03-28', 'Security team'), (567, 617, 'Venue Rental', 30000.00, '2026-03-30', 'Grand Theater full rental'),
(568, 618, 'Armory Rental', 5000.00, '2026-03-10', 'Prop gun rental'), (569, 618, 'Location Fee', 15000.00, '2026-03-15', 'Sunset Ranch rental'), (570, 618, 'Costumes', 12000.00, '2026-03-05', 'Western wardrobe'), (571, 618, 'Transport', 6000.00, '2026-03-20', '4x4 vehicle rental'),
(572, 619, 'Set Dressing', 15000.00, '2026-03-15', 'Ruined props'), (573, 619, 'VFX Budget', 40000.00, '2026-03-30', 'CGI enhancements'), (574, 619, 'Security', 10000.00, '2026-03-20', 'Location security'), (575, 619, 'Transport', 8000.00, '2026-03-25', 'Large equipment transport'),
(576, 620, 'Artist Fees', 25000.00, '2026-03-25', 'Choreographer and lead dancers'), (577, 620, 'Stage Build', 10000.00, '2026-03-10', 'Outdoor stage construction'), (578, 620, 'Security', 12000.00, '2026-03-30', 'Festival security'), (579, 620, 'Venue Fee', 15000.00, '2026-04-05', 'Amphitheater fee'),
-- P621-P650: 2 expenses each
(580, 621, 'SFX Makeup', 7000.00, '2026-02-15', 'Gore effects'), (581, 621, 'Location Fee', 3000.00, '2026-02-20', 'Forest location'),
(582, 622, 'Catering', 2000.00, '2026-03-10', 'Applicant refreshments'), (583, 622, 'Studio Rental', 4000.00, '2026-03-15', 'Studio 54 space'),
(584, 623, 'Mixing Fees', 15000.00, '2026-03-20', 'Engineer and studio time'), (585, 623, 'Mastering', 5000.00, '2026-03-25', 'Final audio preparation'),
(586, 624, 'Editor Salary', 8000.00, '2026-03-10', 'Post-production salary'), (587, 624, 'Camera Rental', 5000.00, '2026-03-15', 'Documentary camera gear'),
(588, 625, 'Costumes', 30000.00, '2026-03-20', 'Armor and robes'), (589, 625, 'VFX Budget', 25000.00, '2026-03-25', 'Dragon CGI'),
(590, 626, 'Set Build', 15000.00, '2026-03-15', 'Spaceship interior'), (591, 626, 'Prop Rental', 4000.00, '2026-03-20', 'Space helmets'),
(592, 627, 'Location Fee', 1000.00, '2026-03-10', 'Park permits'), (593, 627, 'Soundtrack', 6000.00, '2026-03-30', 'Original score'),
(594, 628, 'Vehicle Rental', 8000.00, '2026-03-05', 'RV and cameras'), (595, 628, 'Travel Expense', 3000.00, '2026-03-10', 'Gas and lodging'),
(596, 629, 'SFX Makeup', 10000.00, '2026-03-15', 'Fangs and blood'), (597, 629, 'Lighting', 5000.00, '2026-03-20', 'Mood lighting setup'),
(598, 630, 'Costumes', 20000.00, '2026-03-10', '1920s gowns'), (599, 630, 'Location Fee', 7000.00, '2026-03-15', 'Historical house rental'),
(600, 631, 'Travel Expense', 15000.00, '2026-03-05', 'International flights'), (601, 631, 'Editor Fee', 10000.00, '2026-03-30', 'Post-production fee'),
(602, 632, 'Comedian Fee', 18000.00, '2026-03-10', 'Performer fee'), (603, 632, 'Venue Rental', 4000.00, '2026-03-15', 'Club rental'),
(604, 633, 'Security', 10000.00, '2026-03-20', 'Set security'), (605, 633, 'Writer Fee', 12000.00, '2026-03-25', 'Script polish'),
(606, 634, 'Stunt Coordinator', 8000.00, '2026-03-15', 'Action scene planning'), (607, 634, 'VFX Budget', 30000.00, '2026-03-30', 'Digital effects'),
(608, 635, 'Set Dressing', 10000.00, '2026-03-20', 'Future tech props'), (609, 635, 'VFX Budget', 40000.00, '2026-03-30', 'Time portal rendering'),
(610, 636, 'Set Design', 5000.00, '2026-03-10', 'Living room set'), (611, 636, 'Catering', 3000.00, '2026-03-15', 'On-set snacks'),
(612, 637, 'SFX Equipment', 20000.00, '2026-03-20', 'Wind and rain machines'), (613, 637, 'Stunt Team', 15000.00, '2026-03-25', 'Collapse stunts'),
(614, 638, 'Costumes', 40000.00, '2026-03-10', 'Chainmail and armor'), (615, 638, 'Location Fee', 8000.00, '2026-03-15', 'Forest location'),
(616, 639, 'Choreographer Fee', 7000.00, '2026-03-20', 'Dance routine planning'), (617, 639, 'Sound Mix', 9000.00, '2026-03-30', 'Vocal and music mixing'),
(618, 640, 'Armory Rental', 5000.00, '2026-03-15', 'Weapon props'), (619, 640, 'Security', 10000.00, '2026-03-20', 'Confidential set security'),
(620, 641, 'Venue Rental', 15000.00, '2026-03-25', 'Grand Theater sections'), (621, 641, 'Projection Tech', 5000.00, '2026-03-30', 'A/V specialist'),
(622, 642, 'Security', 12000.00, '2026-03-10', 'Route security and barricades'), (623, 642, 'Medical Staff', 8000.00, '2026-03-15', 'On-site medics'),
(624, 643, 'Venue Rental', 30000.00, '2026-03-20', 'Downtown Arena rental'), (625, 643, 'A/V Setup', 15000.00, '2026-03-25', 'Large screen and sound'),
(626, 644, 'Wine Cost', 20000.00, '2026-03-15', 'Wine purchase for auction'), (627, 644, 'Catering', 10000.00, '2026-03-20', 'Appetizers and canapés'),
(628, 645, 'Venue Rental', 18000.00, '2026-03-10', 'Convention Center hall'), (629, 645, 'Product Samples', 50000.00, '2026-03-15', 'Promotional products'),
(630, 646, 'Art Transport', 5000.00, '2026-03-20', 'Delivery and setup'), (631, 646, 'Catering', 6000.00, '2026-03-25', 'Canapés and drinks'),
(632, 647, 'Speaker Fees', 75000.00, '2026-03-10', 'International speaker fees'), (633, 647, 'Venue Rental', 40000.00, '2026-03-15', 'Multiple Convention Center rooms'),
(634, 648, 'Venue Fee', 10000.00, '2026-03-20', 'Amphitheater ground rental'), (635, 648, 'Marketing', 5000.00, '2026-03-25', 'Local marketing campaign'),
(636, 649, 'Comedian Fee', 15000.00, '2026-03-10', 'Headliner fee'), (637, 649, 'Venue Rental', 3000.00, '2026-03-15', 'Underground Club space'),
(638, 650, 'Venue Rental', 25000.00, '2026-03-20', 'Grand Theater full day rental'), (639, 650, 'Security', 7000.00, '2026-03-25', 'Event security');

INSERT INTO production (production_id, title, production_type, contract_hire_date, contract_expiration_date) VALUES 
(700, 'Neon Night Drive', 'Music', '2025-09-01', '2026-03-31'),
(701, 'Desert Bloom', 'Music', '2025-10-01', '2026-04-30'),
(702, 'The Golden Age', 'General', '2025-11-01', '2027-01-31'),
(703, 'Echoes of the Past', 'Music', '2026-01-01', '2026-06-30'),
(704, 'Silent Storm', 'General', '2026-02-01', '2027-03-31'),
(705, 'Urban Symphony', 'Music', '2026-03-01', '2026-08-31'),
(706, 'Lunar Lullaby', 'Music', '2026-05-01', '2026-10-31'),
(707, 'Shadowlands', 'General', '2026-06-01', '2027-06-30'),
(708, 'Rhythm Nation', 'Music', '2026-08-01', '2027-01-31'),
(709, 'Beyond the Horizon', 'General', '2026-10-01', '2027-09-30'),
(710, 'Deep Dive', 'Music', '2026-11-01', '2027-04-30');

-- Assuming generalproduction fields are (production_id, genre, rating_estimate)
-- We use the 'Music' genre for music productions as per your query.
INSERT INTO generalproduction (production_id, genre, plan_release_quarter, plan_release_year) VALUES 
(700, 'Music', 4, 2025),
(701, 'Music', 1, 2026),
(702, 'History', 3, 2026),
(703, 'Music', 1, 2026),
(704, 'Thriller', 2, 2027), -- Planned for Q2 2027 following Q1 trailer release
(705, 'Music', 1, 2026),
(706, 'Music', 2, 2026),
(707, 'Fantasy', 3, 2027), -- Planned for Q3 2027 following Q1 2027 filming
(708, 'Music', 4, 2026),
(709, 'Sci-Fi', 4, 2027), -- Planned for Q4 2027 following early 2027 pre-production
(710, 'Music', 4, 2026);

INSERT INTO productionschedule (prod_schedule_id, production_id, personnel_id, start_dt, end_dt, taskname, location) VALUES 
-- DEC 2025 (Q4 2025)
(3500, 700, 18, '2025-12-20 09:00:00', '2025-12-20 17:00:00', 'Final Audio Mix Review', 'Post Lab'),
(3501, 700, 37, '2025-12-28 00:00:00', '2025-12-28 23:59:59', 'Music Release (Neon)', 'Digital Platform'),
(3502, 702, 35, '2025-12-18 10:00:00', '2025-12-18 13:00:00', 'Pre-Production Meeting', 'Office'),

-- JAN 2026 (Q1 2026)
(3503, 701, 18, '2026-01-15 08:00:00', '2026-01-15 16:00:00', 'Album Mastering', 'Studio C'),
(3504, 701, 37, '2026-01-25 00:00:00', '2026-01-25 23:59:59', 'Music Release (Desert Bloom)', 'Digital Platform'),
(3505, 702, 4, '2026-01-20 09:00:00', '2026-01-20 17:00:00', 'Lead Role Casting', 'Casting Studio'),

-- FEB 2026 (Q1 2026)
(3506, 703, 18, '2026-02-05 10:00:00', '2026-02-05 14:00:00', 'Demo Recording', 'Studio C'),
(3507, 704, 35, '2026-02-15 07:00:00', '2026-02-15 19:00:00', 'Location Scouting', 'Warehouse District'),
(3508, 703, 37, '2026-02-28 00:00:00', '2026-02-28 23:59:59', 'Music Release (Echoes Preview)', 'Digital Platform'),

-- MAR 2026 (Q1 2026)
(3509, 705, 18, '2026-03-10 10:00:00', '2026-03-10 18:00:00', 'Final Mix', 'Post Lab'),
(3510, 705, 37, '2026-03-25 00:00:00', '2026-03-25 23:59:59', 'Music Release (Urban Symphony)', 'Digital Platform'),
(3511, 704, 4, '2026-03-28 09:00:00', '2026-03-28 17:00:00', 'Costume Design Approval', 'Wardrobe'),

-- APR 2026 (Q2 2026)
(3512, 702, 34, '2026-04-05 08:00:00', '2026-04-10 17:00:00', 'Set Construction Start', 'Backlot'),
(3513, 703, 1, '2026-04-15 09:00:00', '2026-04-15 17:00:00', 'Music Video Shoot', 'Studio 54'),
(3514, 705, 29, '2026-04-28 10:00:00', '2026-04-28 12:00:00', 'Marketing Launch Meeting', 'Office'),

-- MAY 2026 (Q2 2026)
(3515, 706, 18, '2026-05-10 10:00:00', '2026-05-10 18:00:00', 'Instrumental Tracking', 'Studio C'),
(3516, 704, 25, '2026-05-20 07:00:00', '2026-05-20 15:00:00', 'Stunt Choreography', 'Gym'),
(3517, 706, 37, '2026-05-30 00:00:00', '2026-05-30 23:59:59', 'Music Release (Lunar Preview)', 'Digital Platform'),

-- JUN 2026 (Q2 2026)
(3518, 707, 35, '2026-06-15 10:00:00', '2026-06-15 13:00:00', 'Screenplay Read-Through', 'Office'),
(3519, 704, 1, '2026-06-25 06:00:00', '2026-06-25 20:00:00', 'Filming Day 1', 'Warehouse District'),
(3520, 706, 1, '2026-06-28 09:00:00', '2026-06-28 17:00:00', 'Music Video Shoot', 'Outdoor Venue'),

-- JUL 2026 (Q3 2026)
(3521, 706, 29, '2026-07-10 10:00:00', '2026-07-10 12:00:00', 'Media Interview Planning', 'Office'),
(3522, 707, 4, '2026-07-20 09:00:00', '2026-07-20 17:00:00', 'Supporting Role Casting', 'Casting Studio'),
(3523, 707, 24, '2026-07-30 14:00:00', '2026-07-30 16:00:00', 'Budget Finalization', 'Office'),

-- AUG 2026 (Q3 2026)
(3524, 708, 18, '2026-08-15 10:00:00', '2026-08-15 18:00:00', 'Vocal Recording', 'Studio C'),
(3525, 704, 27, '2026-08-25 09:00:00', '2026-08-25 17:00:00', 'VFX Pre-visualization', 'Post Lab'),
(3526, 708, 37, '2026-08-30 00:00:00', '2026-08-30 23:59:59', 'Music Release (Rhythm Preview)', 'Digital Platform'),

-- SEP 2026 (Q3 2026)
(3527, 702, 37, '2026-09-10 10:00:00', '2026-09-10 17:00:00', 'Press Junket', 'Hotel Ballroom'),
(3528, 707, 34, '2026-09-20 08:00:00', '2026-09-20 18:00:00', 'Props Fabrication', 'Workshop'),
(3529, 702, 2, '2026-09-30 18:00:00', '2026-09-30 23:00:00', 'Premiere Screening', 'Cinema Complex'),

-- OCT 2026 (Q4 2026)
(3530, 709, 35, '2026-10-15 10:00:00', '2026-10-15 12:00:00', 'Director''s Vision Meeting', 'Office'),
(3531, 708, 1, '2026-10-25 18:00:00', '2026-10-25 23:00:00', 'Music Video Shoot', 'Night Club'),
(3532, 708, 37, '2026-10-30 00:00:00', '2026-10-30 23:59:59', 'Music Release (Rhythm Nation)', 'Digital Platform'),

-- NOV 2026 (Q4 2026)
(3533, 710, 18, '2026-11-10 09:00:00', '2026-11-10 17:00:00', 'Track Mixing', 'Post Lab'),
(3534, 709, 4, '2026-11-20 09:00:00', '2026-11-20 17:00:00', 'Main Cast Auditions', 'Casting Studio'),
(3535, 710, 37, '2026-11-30 00:00:00', '2026-11-30 23:59:59', 'Music Release (Deep Dive Preview)', 'Digital Platform'),

-- DEC 2026 (Q4 2026)
(3536, 707, 1, '2026-12-05 06:00:00', '2026-12-05 20:00:00', 'Filming Day 1', 'Remote Location'),
(3537, 710, 1, '2026-12-15 08:00:00', '2026-12-15 18:00:00', 'Music Video Shoot', 'Underwater Studio'),
(3538, 709, 29, '2026-12-28 10:00:00', '2026-12-28 12:00:00', 'Press Release Drafting', 'Office'),

-- JAN 2027 (Q1 2027)
(3539, 704, 27, '2027-01-15 09:00:00', '2027-01-15 17:00:00', 'Color Grading', 'Post Lab'),
(3540, 707, 25, '2027-01-25 07:00:00', '2027-01-25 15:00:00', 'Action Choreography', 'Gym'),
(3541, 710, 29, '2027-01-30 14:00:00', '2027-01-30 16:00:00', 'Album Artwork Approval', 'Office'),

-- FEB 2027 (Q1 2027)
(3542, 709, 27, '2027-02-10 10:00:00', '2027-02-10 17:00:00', 'Storyboard Finalization', 'Office'),
(3543, 707, 15, '2027-02-20 10:00:00', '2027-02-20 12:00:00', 'Investor Presentation', 'Office'),
(3544, 704, 37, '2027-02-28 00:00:00', '2027-02-28 23:59:59', 'Final Movie Trailer Release', 'Digital Platform'),

-- MAR 2027 (Q1 2027)
(3545, 709, 34, '2027-03-10 08:00:00', '2027-03-15 17:00:00', 'Set Design Commencement', 'Backlot'),
(3546, 707, 1, '2027-03-20 06:00:00', '2027-03-20 20:00:00', 'Filming Day 10', 'Studio 54'),
(3547, 704, 2, '2027-03-30 10:00:00', '2027-03-30 13:00:00', 'Premiere Event Booking', 'Theater Hall');
-- =============================================
-- DATA FIX: UNIFY PERSONNEL TYPE (Actress -> Actor)
-- This ensures consistency across the dataset.
-- =============================================
UPDATE personnel
SET personnel_type = 'Actor'
WHERE personnel_type = 'Actress';


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
