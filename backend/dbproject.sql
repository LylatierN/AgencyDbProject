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
(23, 'Julia Rob.', 'julia@pretty.com', '555-0503', 'Actress', '2022-01-01', '2026-01-01'),
(24, 'Emma Sto.', 'emma@lalaland.com', '555-0504', 'Actress', '2023-01-01', '2027-01-01'),
(25, 'Chris Hem.', 'chris@thor.com', '555-0505', 'Actor', '2022-05-01', '2025-05-01'),
(26, 'Ryan Gos.', 'ryan@ken.com', '555-0506', 'Actor', '2023-01-01', '2026-01-01'),
(27, 'Zendaya C.', 'zen@dune.com', '555-0507', 'Actress', '2023-06-01', '2027-01-01'),
(28, 'Timothee C.', 'tim@dune.com', '555-0508', 'Actor', '2023-06-01', '2027-01-01'),
(29, 'Viola D.', 'viola@fences.com', '555-0509', 'Actress', '2021-08-01', '2025-08-01'),
(30, 'Denzel W.', 'denzel@equalizer.com', '555-0510', 'Actor', '2021-09-01', '2025-09-01'),
-- Actors with NO jobs (for Query 6)
(31, 'Silent Extra', 'silent@extra.com', '555-0601', 'Actor', '2024-01-01', '2024-12-31'),
(32, 'Background B', 'bg@extra.com', '555-0602', 'Actress', '2024-01-01', '2024-12-31'),
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
(100, 'Gourmet Catering', 'Food', 17, '2023-01-01', '2024-12-31', 50000.00, 'Kitchen HQ'),
(101, 'Fast Logistics', 'Transport', 18, '2023-01-01', '2025-12-31', 75000.00, 'Fleet HQ'),
(102, 'Bright Lights Inc', 'Lighting', 19, '2024-01-01', '2025-01-01', 30000.00, 'Warehouse A'),
(103, 'Crystal Clear Audio', 'Sound', 20, '2023-06-01', '2024-06-01', 25000.00, 'Studio B'),
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
(501, 10, 'Catering', 1200.50, '2023-01-15', 'Lunch'),
(502, 10, 'Props', 500.00, '2023-01-20', 'Swords'),
(503, 11, 'Sound', 5000.00, '2024-02-05', 'Speakers'),
(504, 12, 'Costume', 3000.00, '2024-01-10', 'Dresses'),
(505, 12, 'Makeup', 1500.00, '2024-01-11', 'Prosthetics'),
(506, 13, 'VFX', 10000.00, '2025-02-01', 'CGI render'),
(507, 19, 'Travel', 2000.00, '2024-09-01', 'Flights'),
-- NEW EXPENSES
(508, 20, 'Pyrotechnics', 15000.00, '2024-06-01', 'Explosions'),
(509, 21, 'Flowers', 800.00, '2023-03-14', 'Wedding Scene'),
(510, 25, 'CGI', 50000.00, '2025-06-01', 'Monster render'),
(511, 28, 'Catering', 4000.00, '2024-02-10', 'Champagne'),
(512, 34, 'Marketing', 10000.00, '2024-01-01', 'Billboards'),
(513, 39, 'Cars', 30000.00, '2025-06-15', 'Stunt cars purchase');
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
