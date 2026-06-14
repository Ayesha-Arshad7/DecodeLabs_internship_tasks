# 📊 DecodeLabs — Data Analytics Portfolio

Welcome to my data analytics portfolio! This repository contains 3 end-to-end projects covering the full data pipeline — from raw data cleaning to SQL-based business intelligence.

---

## 👤 About Me

**Organization:** DecodeLabs  
**Role:** Data Analyst Intern  
**Tools Used:** Python (pandas, numpy), MySQL Workbench, Microsoft Excel  
**Dataset:** E-Commerce Orders Dataset (1,200 records)

---

## 📁 Project Overview

| Project | Title | Skills Used |
|---------|-------|-------------|
| Project 1 | Data Cleaning & Preparation | Python, pandas, numpy |
| Project 2 | Exploratory Data Analysis (EDA) | Python, pandas, matplotlib/seaborn |
| Project 3 | SQL Data Analysis | MySQL, Aggregations, Business Intelligence |

---

## 🧹 Project 1 — Data Cleaning & Preparation

**File:** `project1-data-cleaning/decodes_project_1.ipynb`

### 📌 Objective
Clean and prepare the raw e-commerce dataset so it is ready for analysis — handling missing values, duplicates, date formatting, and numeric precision.

### 📊 Dataset
- **Rows:** 1,200 orders
- **Columns:** 14 features (OrderID, Date, Product, TotalPrice, OrderStatus, etc.)

### 🔧 Steps Performed

| ID | Column | Issue Found | Action Taken | Status |
|----|--------|-------------|--------------|--------|
| CR001 | CouponCode | 309 missing values | Filled nulls with `'No Coupon'` | ✅ Resolved |
| CR002 | OrderID | Duplicate check | 0 duplicates found | ✅ Verified |
| CR003 | Date | Wrong format (timestamps) | Converted to `YYYY-MM-DD` | ✅ Resolved |
| CR004 | TotalPrice / UnitPrice | Float precision errors | Rounded to 2 decimal places | ✅ Resolved |
| CR005 | All text columns | Extra whitespace | Applied `str.strip()` | ✅ Verified |

### ✅ Final Verification Results
- Missing values remaining: **0**
- Duplicate rows: **0**
- Incorrectly formatted dates: **0**
- Output saved as: `Cleaned_Dataset.xlsx`

### 🛠️ Libraries Used
```python
import pandas as pd
import numpy as np
```

---

## 🔍 Project 2 — Exploratory Data Analysis (EDA)

**File:** `project2-EDA/DecodeLabs_EDA_Project2.ipynb`

### 📌 Objective
Explore the cleaned dataset to find patterns, trends, and insights using descriptive statistics and data visualizations.

### 📊 Key Areas Explored

- **Sales Trends** — Monthly and quarterly revenue patterns
- **Product Performance** — Best and worst selling products by revenue and quantity
- **Customer Behavior** — Order frequency, average order value, cart size analysis
- **Payment Methods** — Which payment methods drive more revenue
- **Referral Sources** — Which traffic channels (Instagram, Google, Facebook, Email, Referral) bring the most orders
- **Coupon Analysis** — Impact of discount codes on sales volume and revenue
- **Order Status Breakdown** — Delivered vs Cancelled vs Returned vs Pending

### 📈 Visualizations Created
- Bar charts — Revenue by product, orders by referral source
- Line charts — Monthly revenue trend over time
- Pie charts — Order status distribution, payment method share
- Heatmaps — Product × Status matrix

### 🛠️ Libraries Used
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
```

---

## 🗃️ Project 3 — SQL Data Analysis

**File:** `project3-SQL/DecodeLabs_Project3_SQL_Analysis.sql`

### 📌 Objective
Write structured SQL queries to extract business insights from the e-commerce orders database — covering filtering, aggregations, grouping, and a full performance dashboard.

### 🗂️ Database Schema

```
Table: orders
├── OrderID        VARCHAR    Unique order identifier
├── Date           DATE       Order placement date
├── CustomerID     VARCHAR    Unique customer identifier
├── Product        VARCHAR    Product name
├── Quantity       INT        Units ordered
├── UnitPrice      DECIMAL    Price per unit
├── ShippingAddress VARCHAR   Delivery address
├── PaymentMethod  VARCHAR    Payment method used
├── OrderStatus    VARCHAR    Shipped / Cancelled / Returned / Delivered / Pending
├── TrackingNumber VARCHAR    Shipment tracking ID
├── ItemsInCart    INT        Total items in the customer's cart
├── CouponCode     VARCHAR    Coupon applied (SAVE10, FREESHIP, WINTER15, NULL)
├── ReferralSource VARCHAR    Traffic source (Instagram, Facebook, Google, Email, Referral)
└── TotalPrice     DECIMAL    Final order value
```

### 📋 SQL Sections Covered

| Section | Topic | Queries |
|---------|-------|---------|
| Section 1 | Data Exploration | Preview, record count, date range, distinct values |
| Section 2 | SELECT + WHERE | Filtering by status, price, date, payment method, coupon |
| Section 3 | ORDER BY | Sorting by price, date, product name, cart size |
| Section 4 | GROUP BY + Aggregations | Revenue by product, status, payment method, referral, coupon, month |
| Section 5 | HAVING | Filtering aggregated results (high revenue products, top payment methods) |
| Section 6 | Business Intelligence | Customer LTV, cancellation rate, return rate, quarterly summary, dashboard |

### 💡 Key Business Queries

```sql
-- Cancellation rate per product
SELECT Product,
       ROUND(SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(OrderID), 2) AS cancellation_rate_pct
FROM orders
GROUP BY Product
ORDER BY cancellation_rate_pct DESC;

-- Top 10 customers by lifetime spend
SELECT CustomerID, COUNT(OrderID) AS total_orders, SUM(TotalPrice) AS lifetime_value
FROM orders
GROUP BY CustomerID
ORDER BY lifetime_value DESC
LIMIT 10;

-- Quarterly revenue summary
SELECT YEAR(Date) AS year, CONCAT('Q', QUARTER(Date)) AS quarter,
       COUNT(OrderID) AS total_orders, SUM(TotalPrice) AS quarterly_revenue
FROM orders
GROUP BY YEAR(Date), QUARTER(Date)
ORDER BY year, QUARTER(Date);
```

### 🛠️ Tools Used
- **MySQL Workbench** — Query execution and database management
- **Aggregate Functions** — COUNT, SUM, AVG, ROUND
- **Conditional Logic** — CASE WHEN, COALESCE, IS NULL
- **Date Functions** — YEAR(), MONTH(), QUARTER()

---

## 📦 Repository Structure

```
DecodeLabs-Data-Analytics/
│
├── README.md
│
├── project1-data-cleaning/
│   ├── decodes_project_1.ipynb
│   └── Dataset_for_Data_Analytics.xlsx
│
├── project2-EDA/
│   ├── DecodeLabs_EDA_Project2.ipynb
│   └── Cleaned_Dataset.xlsx
│
└── project3-SQL/
    ├── DecodeLabs_Project3_SQL_Analysis.sql
    └── Dataset_for_Data_Analytics.xlsx
```

---

## 🚀 How to Run

### Python Projects (Project 1 & 2)
1. Python 3.x install karo
2. Required libraries install karo:
   ```bash
   pip install pandas numpy matplotlib seaborn openpyxl
   ```
3. Jupyter Notebook open karo:
   ```bash
   jupyter notebook
   ```
4. `.ipynb` file run karo cell by cell

### SQL Project (Project 3)
1. MySQL Workbench install karo
2. Naya schema banao: `decodelabs`
3. Dataset import karo (Table Data Import Wizard)
4. `.sql` file open karo aur queries run karo

---

## 📬 Contact

**DecodeLabs Data Team**  
Feel free to explore, fork, or star ⭐ this repository!

---

*This project was completed as part of a Data Analytics internship program at DecodeLabs.*
