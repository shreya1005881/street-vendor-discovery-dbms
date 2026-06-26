# 🌶️ SPICE – Street Food Platform for Information, Customer Reviews & Exploration

> DBMS Project | DA-IICT | Semester 4

A relational database system for discovering, reviewing, and evaluating street food vendors across cities. SPICE centralizes vendor information, food menus, hygiene records, and customer reviews into a structured and queryable database.

---

## 📁 Repository Structure

```
street-vendor-discovery-dbms/
│
├── diagrams/               # ERD and Relational Schema diagrams
│
├── docs/                   # Project documentation
│   ├── BCNF_Normalization.pdf
│   ├── Minimal_FD_Sets.pdf
│   └── QUERIESandDML.docx
│
├── sql/                    # SQL scripts
│   └── INSERT.txt          # DML – sample data insert statements
│
└── README.md
```

---

## 🗃️ Database Schema

The system consists of **12 relational tables**:

| # | Table | Description |
|---|-------|-------------|
| 1 | `City` | Stores city and state information |
| 2 | `Vendor` | Registered street food vendors |
| 3 | `Stall` | Vendor stall details and location |
| 4 | `Food_Category` | Categories of food items |
| 5 | `Food_Item` | Individual food items |
| 6 | `Menu` | Maps a menu to each stall (1:1) |
| 7 | `Menu_Item` | Food items listed in a menu with price |
| 8 | `Customer` | Registered platform users |
| 9 | `Review` | Customer ratings and comments |
| 10 | `Authority` | Municipal/food safety authorities |
| 11 | `License` | Vendor operating licenses |
| 12 | `Inspection` | Hygiene inspection records |

---

## 👥 Application Users

- **Visitors** – Browse vendors and menus without an account
- **Customers** – Register, rate vendors, and write reviews
- **Vendors** – List stalls, manage menus, and track reputation
- **Authorities** – Record inspections and manage licenses

---

## ⚙️ Key Features

- Vendor and stall registration with location tracking
- Food menu management with pricing and availability
- Customer review and rating system (1–5 stars)
- Hygiene inspection tracking with scores and remarks
- License management (Valid / Expired / Suspended)
- Vendor Trust Score based on hygiene, ratings, and experience

---

## 🛠️ Tech Stack

- **Database:** MySQL / Oracle SQL
- **Normalization:** BCNF
- **Documentation:** PDF, DOCX

---

## 📄 Documentation

| Document | Description |
|----------|-------------|
| `BCNF_Normalization.pdf` | BCNF decomposition for all 12 tables |
| `Minimal_FD_Sets.pdf` | Canonical cover / minimal FD sets |
| `QUERIESandDML.docx` | SQL queries and DML operations |
| `INSERT.txt` | Sample data for all tables |

---

## 🏫 Project Info

**Course:** Database Management Systems (IT214)  
**Institute:** Dhirubhai Ambani Institute of Information and Communication Technology (DA-IICT), Gandhinagar  
**Semester:** 4 | Academic Year 2024–25
