-- ============================================================
--  Street Vendor Discovery System — DDL Script (Updated)
--  DA-IICT | DBMS Project
--  Changes marked with -- [NEW]
-- ============================================================

CREATE SCHEMA StreetFoodDB;
SET search_path TO StreetFoodDB;

-- ------------------------------------------------------------
-- 1. CITY
-- ------------------------------------------------------------
CREATE TABLE City (
    City_ID   INT          PRIMARY KEY,
    City_Name VARCHAR(50)  NOT NULL,
    State     VARCHAR(50)  NOT NULL
);

-- ------------------------------------------------------------
-- 2. VENDOR
-- ------------------------------------------------------------
CREATE TABLE Vendor (
    Vendor_ID           INT          PRIMARY KEY,
    Vendor_Name         VARCHAR(50)  NOT NULL,
    Contact_No          VARCHAR(15)  UNIQUE NOT NULL,
    Years_of_Experience INT          CHECK (Years_of_Experience >= 0),
    Average_Rating      FLOAT        CHECK (Average_Rating >= 0 AND Average_Rating <= 5),
    Registration_Date   DATE         DEFAULT CURRENT_DATE,  -- [NEW]
    Role                VARCHAR(30)                         -- [NEW]
);

-- ------------------------------------------------------------
-- 3. STALL
-- ------------------------------------------------------------
CREATE TABLE Stall (
    Stall_ID           INT          PRIMARY KEY,
    Stall_Name         VARCHAR(50)  NOT NULL,
    Location           VARCHAR(100),
    Opening_Time       TIME,
    Closing_Time       TIME,
    Payment_Method     VARCHAR(30)  DEFAULT 'Cash',         -- [NEW]
    Is_Mobile          BOOLEAN      DEFAULT FALSE,          -- [NEW]
    Seating_Available  BOOLEAN      DEFAULT FALSE,          -- [NEW]
    Vendor_ID          INT,
    City_ID            INT,
    FOREIGN KEY (Vendor_ID) REFERENCES Vendor(Vendor_ID) ON DELETE CASCADE,
    FOREIGN KEY (City_ID)   REFERENCES City(City_ID)     ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- 4. FOOD CATEGORY
-- ------------------------------------------------------------
CREATE TABLE Food_Category (
    Category_ID   INT          PRIMARY KEY,
    Category_Name VARCHAR(50)  NOT NULL,
    Description   VARCHAR(100)
);

-- ------------------------------------------------------------
-- 5. FOOD ITEM
-- ------------------------------------------------------------
CREATE TABLE Food_Item (
    Food_ID     INT          PRIMARY KEY,
    Food_Name   VARCHAR(50)  NOT NULL,
    Description VARCHAR(100),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Food_Category(Category_ID) ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- 6. MENU
-- ------------------------------------------------------------
CREATE TABLE Menu (
    Menu_ID  INT PRIMARY KEY,
    Stall_ID INT UNIQUE,
    FOREIGN KEY (Stall_ID) REFERENCES Stall(Stall_ID) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 7. MENU_ITEM
-- ------------------------------------------------------------
CREATE TABLE Menu_Item (
    Menu_ID      INT,
    Food_ID      INT,
    Price        FLOAT    CHECK (Price >= 0),               -- [UPDATED: INT -> FLOAT]
    Availability BOOLEAN  DEFAULT TRUE,
    Dietary_Tag  VARCHAR(20) DEFAULT 'Veg',                 -- [NEW] e.g. Veg, Non-Veg, Jain
    Is_Seasonal  BOOLEAN  DEFAULT FALSE,                    -- [NEW]
    PRIMARY KEY (Menu_ID, Food_ID),
    FOREIGN KEY (Menu_ID) REFERENCES Menu(Menu_ID)          ON DELETE CASCADE,
    FOREIGN KEY (Food_ID) REFERENCES Food_Item(Food_ID)     ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 8. CUSTOMER
-- ------------------------------------------------------------
CREATE TABLE Customer (
    Customer_ID       INT          PRIMARY KEY,
    First_Name        VARCHAR(30)  NOT NULL,
    Last_Name         VARCHAR(30),
    Email             VARCHAR(50)  UNIQUE,
    Phone             VARCHAR(15),
    Registration_Date DATE         DEFAULT CURRENT_DATE
);

-- ------------------------------------------------------------
-- 9. REVIEW
-- ------------------------------------------------------------
CREATE TABLE Review (
    Review_ID   INT          PRIMARY KEY,
    Rating      INT          CHECK (Rating BETWEEN 1 AND 5),
    Comment     VARCHAR(200),
    Review_Date DATE         DEFAULT CURRENT_DATE,
    Visit_Count INT          DEFAULT 1 CHECK (Visit_Count >= 1), -- [NEW]
    Customer_ID INT          NOT NULL,
    Stall_ID    INT          NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Stall_ID)    REFERENCES Stall(Stall_ID)       ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 10. AUTHORITY
-- ------------------------------------------------------------
CREATE TABLE Authority (
    Authority_ID INT          PRIMARY KEY,
    Name         VARCHAR(50)  NOT NULL,
    Department   VARCHAR(50),
    Contact      VARCHAR(15),
    Role         VARCHAR(30)
);

-- ------------------------------------------------------------
-- 11. LICENSE
-- ------------------------------------------------------------
CREATE TABLE License (
    License_ID   INT          PRIMARY KEY,
    Issue_Date   DATE         NOT NULL,
    Expiry_Date  DATE         NOT NULL,
    Status       VARCHAR(20)  CHECK (Status IN ('Valid', 'Expired', 'Suspended')),
    License_Type VARCHAR(30),
    Vendor_ID    INT,
    Authority_ID INT,
    CHECK (Expiry_Date > Issue_Date),
    FOREIGN KEY (Vendor_ID)    REFERENCES Vendor(Vendor_ID)       ON DELETE CASCADE,
    FOREIGN KEY (Authority_ID) REFERENCES Authority(Authority_ID) ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- 12. INSPECTION
-- ------------------------------------------------------------
CREATE TABLE Inspection (
    Inspection_ID    INT          PRIMARY KEY,
    Inspection_Date  DATE         NOT NULL,
    Hygiene_Rating   FLOAT        CHECK (Hygiene_Rating BETWEEN 0 AND 5),
    Remarks          VARCHAR(200),
    Violation_History TEXT,                                 -- [NEW]
    Stall_ID         INT,
    Authority_ID     INT,
    FOREIGN KEY (Stall_ID)     REFERENCES Stall(Stall_ID)         ON DELETE CASCADE,
    FOREIGN KEY (Authority_ID) REFERENCES Authority(Authority_ID) ON DELETE SET NULL
);
