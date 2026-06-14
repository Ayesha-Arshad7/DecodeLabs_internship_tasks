# 📊 DecodeLabs  Data Analytics Portfolio

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
| Project 2 | Exploratory Data Analysis (EDA) | Python, pandas, matplotlib, seaborn |
| Project 3 | SQL Data Analysis | MySQL, Aggregations, Business Intelligence |

---

## 🧹 Project 1 — Data Cleaning & Preparation

**File:** `project1-data-cleaning/decodes_project_1.ipynb`

### Objective
Clean and prepare the raw e-commerce dataset so it is ready for analysis — handling missing values, duplicates, date formatting, and numeric precision issues.

### Dataset
- **Rows:** 1,200 orders
- **Columns:** 14 features (OrderID, Date, Product, TotalPrice, OrderStatus, etc.)

### Steps Performed

| ID | Column | Issue Found | Action Taken | Status |
|----|--------|-------------|--------------|--------|
| CR001 | CouponCode | 309 missing values | Filled nulls with 'No Coupon' | ✅ Resolved |
| CR002 | OrderID | Duplicate check | 0 duplicates found | ✅ Verified |
| CR003 | Date | Incorrect format | Converted to YYYY-MM-DD | ✅ Resolved |
| CR004 | TotalPrice / UnitPrice | Float precision errors | Rounded to 2 decimal places | ✅ Resolved |
| CR005 | All text columns | Leading/trailing whitespace | Applied str.strip() | ✅ Verified |

### Final Verification Results
- Missing values remaining: **0**
- Duplicate rows: **0**
- Incorrectly formatted dates: **0**
- Output saved as: `Cleaned_Dataset.xlsx`

### Libraries Used
```python
import pandas as pd
import numpy as np
```

---

## 🔍 Project 2 — Exploratory Data Analysis (EDA)

**File:** `project2-EDA/DecodeLabs_EDA_Project2.ipynb`

### Objective
Explore the cleaned dataset to uncover patterns, trends, and actionable insights using descriptive statistics and data visualizations.

### Key Areas Explored
- **Sales Trends** — Monthly and quarterly revenue patterns over time
- **Product Performance** — Best and worst selling products by revenue and quantity
- **Customer Behavior** — Order frequency, average order value, and cart size analysis
- **Payment Methods** — Which payment methods generate the most revenue
- **Referral Sources** — Which traffic channels bring the most orders
- **Coupon Analysis** — Impact of discount codes on sales volume and revenue
- **Order Status Breakdown** — Distribution of Delivered, Cancelled, Returned, and Pending orders

### Visualizations Created
- Bar charts — Revenue by product, orders by referral source
- Line charts — Monthly revenue trend over time
- Pie charts — Order status distribution, payment method share
- Heatmaps — Product × Status performance matrix

### Libraries Used
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
```

---

## 🗃️ Project 3 — SQL Data Analysis

**File:** `project3-SQL/DecodeLabs_Project3_SQL_Analysis.sql`

### Objective
Write structured SQL queries to extract business insights from the e-commerce orders database — covering filtering, aggregations, grouping, and a full business intelligence dashboard.

### Database Schema
```
Table: orders
├── OrderID         VARCHAR    Unique order identifier
├── Date            DATE       Order placement date
├── CustomerID      VARCHAR    Unique customer identifier
├── Product         VARCHAR    Product name
├── Quantity        INT        Units ordered
├── UnitPrice       DECIMAL    Price per unit
├── PaymentMethod   VARCHAR    Payment method used
├── OrderStatus     VARCHAR    Shipped / Cancelled / Returned / Delivered / Pending
├── CouponCode      VARCHAR    Coupon applied (SAVE10, FREESHIP, WINTER15, NULL)
├── ReferralSource  VARCHAR    Traffic source (Instagram, Facebook, Google, Email, Referral)
└── TotalPrice      DECIMAL    Final order value
```

### SQL Sections Covered

| Section | Topic | Description |
|---------|-------|-------------|
| Section 1 | Data Exploration | Preview rows, record count, date range, distinct values |
| Section 2 | SELECT + WHERE | Filter by status, price, date, payment method, coupon |
| Section 3 | ORDER BY | Sort by price, date, product name, and cart size |
| Section 4 | GROUP BY + Aggregations | Revenue by product, status, payment method, referral, and month |
| Section 5 | HAVING | Filter aggregated results for high-revenue products and top payment methods |
| Section 6 | Business Intelligence | Customer LTV, cancellation rate, return rate, quarterly summary, full dashboard |

### Key Business Queries
```sql
-- Cancellation rate per product
SELECT Product,
       ROUND(SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(OrderID), 2)
       AS cancellation_rate_pct
FROM orders GROUP BY Product ORDER BY cancellation_rate_pct DESC;

-- Top 10 customers by lifetime spend
SELECT CustomerID, COUNT(OrderID) AS total_orders, SUM(TotalPrice) AS lifetime_value
FROM orders GROUP BY CustomerID ORDER BY lifetime_value DESC LIMIT 10;

-- Quarterly revenue summary
SELECT YEAR(Date) AS year, CONCAT('Q', QUARTER(Date)) AS quarter,
       SUM(TotalPrice) AS quarterly_revenue
FROM orders GROUP BY YEAR(Date), QUARTER(Date) ORDER BY year, QUARTER(Date);
```

### Tools Used
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
├── project1-data-cleaning/
│   ├── decodes_project_1.ipynb
│   └── Dataset_for_Data_Analytics.xlsx
├── project2-EDA/
│   ├── DecodeLabs_EDA_Project2.ipynb
│   └── Cleaned_Dataset.xlsx
└── project3-SQL/
    ├── DecodeLabs_Project3_SQL_Analysis.sql
    └── Dataset_for_Data_Analytics.xlsx
```

---

## 🚀 How to Run

**Python Projects (Project 1 & 2)**
1. Install Python 3.x
2. Run `pip install pandas numpy matplotlib seaborn openpyxl`
3. Open Jupyter Notebook and run the `.ipynb` file cell by cell

**SQL Project (Project 3)**
1. Install MySQL Workbench
2. Create a schema named `decodelabs`
3. Import the dataset using the Table Data Import Wizard
4. Open the `.sql` file and execute the queries

---

*This portfolio was completed as part of a Data Analytics internship program at DecodeLabs.*
⭐ If you find this helpful, please give the repository a star!


