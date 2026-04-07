# 📊 Sales Analytics Dashboard — SQL + Power BI

> A structured, end-to-end analytics project built on a real-world sales dataset. Covers the full pipeline from raw transactional data → SQL validation → data modeling → DAX measures → interactive dashboard — delivering decision-ready insights across markets, customers, and products.

📦 **Database:** Sales (MySQL transactional dataset)
🛠 **Stack:** MySQL · Power BI · DAX · Data Modeling
🏢 **Domain:** Retail & E-Commerce Sales Analytics

---

## Table of Contents

* [Project Overview](#project-overview)
* [Understanding the Database](#understanding-the-database)
* [Analytics Pipeline — Stage by Stage](#analytics-pipeline--stage-by-stage)
* [Power BI Data Modeling](#power-bi-data-modeling)
* [DAX Measures (Business Logic)](#dax-measures-business-logic)
* [Dashboard Walkthrough](#dashboard-walkthrough)
* [SQL Concepts Demonstrated](#sql-concepts-demonstrated)
* [Key Business Insights Unlocked](#key-business-insights-unlocked)
* [Why This Project Matters (Technical Depth)](#why-this-project-matters-technical-depth)
* [Getting Started](#getting-started)

---

## Project Overview

This project builds a **complete business intelligence solution** for a multi-market sales organization operating across **Brick & Mortar and E-Commerce channels**.

The business problem:

Decision-makers lack a **centralized, reliable system** to answer:

* What is the total revenue and how is it trending over time?
* Which markets and customers contribute the most?
* Are we profitable — and where are margins leaking?
* How does performance compare across channels?
* Which products are driving growth?

This project solves these questions by combining:

* **SQL → Data validation & exploration**
* **Data modeling → Structured relationships**
* **DAX → Business logic layer**
* **Power BI → Interactive decision dashboard**

---

## Understanding the Database

The dataset follows a **relational structure**, later transformed into a **star schema** for analytics.

👉 Full database schema available here:
db_dump.sql


### Core Tables

**1. `transactions` (Fact Table)**

* Sales amount
* Sales quantity
* Product, customer, market references
* Order date

**2. `customers` (Dimension)**

* Customer name
* Customer type (Brick & Mortar / E-Commerce)

**3. `date` (Time Dimension)**

* Year, month
* Custom formatted date fields

---

### Key Design Insight

> The transactional table stores **codes, not descriptions**

Example:

* `customer_code = Cus006`
* Actual name → resolved via JOIN

👉 This ensures:

* No redundancy
* Faster queries
* Scalable analytics

---

## Analytics Pipeline — Stage by Stage

---

### Stage 1 · Data Exploration (SQL)

Before building dashboards, the dataset is explored to understand structure and patterns.

```sql
SELECT * FROM transactions WHERE market_code = 'Mark001';

SELECT * FROM transactions WHERE YEAR(order_date) = 2020;
```

**Purpose:**

* Validate data consistency
* Understand distribution across years and markets

---

### Stage 2 · Revenue Analysis

```sql
SELECT 
    SUM(sales_amount) AS total_revenue,
    YEAR(order_date) AS year
FROM sales.transactions
GROUP BY YEAR(order_date)
HAVING year = 2019;
```

**What this solves:**

* Annual revenue tracking
* Business growth measurement

---

### Stage 3 · Monthly Revenue Trends

```sql
SELECT 
    SUM(sales_amount) AS total_revenue,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month
FROM sales.transactions
GROUP BY YEAR(order_date), MONTH(order_date)
HAVING year = 2020 AND month = 1;
```

**Why this matters:**

* Identifies seasonality
* Detects demand fluctuations

---

### Stage 4 · Market-Level Analysis

```sql
SELECT 
    SUM(sales_amount) AS total_revenue
FROM transactions
WHERE market_code = 'Mark001'
AND YEAR(order_date) = 2020;
```

**Insight:**

* Market-specific performance evaluation

---

### Stage 5 · Product-Level Analysis

```sql
SELECT DISTINCT product_code 
FROM transactions 
WHERE market_code = 'Mark001';
```

**Purpose:**

* Understand product diversity
* Enable top-product identification

---

### Stage 6 · Time-Specific Revenue

```sql
SELECT SUM(sales_amount)
FROM transactions
WHERE MONTH(order_date) = 1
AND YEAR(order_date) = 2020;
```

**Business use-case:**

* Monthly performance reporting
* KPI tracking

---

## Power BI Data Modeling

The dataset is transformed into a **star schema** inside Power BI.

### Structure

* **Fact Table:** Transactions
* **Dimensions:** Customers, Products, Markets, Date

### Relationships

* Transactions → Customers
* Transactions → Date
* Transactions → Products

---

### Why Star Schema?

* Faster aggregations
* Cleaner filtering
* Scalable design

> This is the industry standard for BI systems

---

## DAX Measures (Business Logic)

This layer converts raw data into **decision-ready KPIs**

---

### Core Metrics

```dax
Revenue = SUM('sales transactions (2)'[norm_sales_amount])

Sales Qty = SUM('sales transactions'[sales_qty])

Total Profit Margin = SUM('sales transactions (2)'[profit_margin])
```

---

### Derived Metrics

```dax
Profit margin % = DIVIDE([Total Profit Margin], [Revenue], 0)
```

---

```dax
Revenue contribution% = 
DIVIDE(
    [Revenue],
    CALCULATE(
        [Revenue],
        ALL('sales products'),
        ALL('sales customers'),
        ALL('sales markets')
    )
)
```

---

```dax
Profit Margin contribution % = 
DIVIDE(
    [Total Profit Margin],
    CALCULATE(
        [Total Profit Margin],
        ALL('sales products'),
        ALL('sales customers'),
        ALL('sales markets')
    )
)
```

---

```dax
Revenue Last Year = 
CALCULATE(
    [Revenue],
    SAMEPERIODLASTYEAR('sales date'[date])
)
```

---

```dax
Target Diff = 
[Profit margin %] - 'Profit Target'[Profit Target Value]
```

---

### Key Design Insight

> Measures are written using `ALL()` to remove filters — enabling true contribution calculations.

Without this:

* Contribution % would be **wrong (filtered context)**

---

## Dashboard Walkthrough

---

### KPI Layer

* Revenue → ₹142.22M
* Sales Quantity → 350K
* Profit Margin → ₹2.1M

👉 Instant business snapshot

---

### Market Analysis

* Revenue by market
* Profit contribution
* Sales quantity

👉 Identifies dominant regions

---

### Time Series Analysis

* Monthly revenue trend
* Revenue vs last year
* Profit margin trend

👉 Detects growth & decline patterns

---

### Customer Analysis

* Revenue by customer
* Profit margin %
* Contribution %

👉 Highlights key accounts

---

### Product Analysis

* Top-performing products

👉 Helps inventory & strategy decisions

---

### Interactivity

* Year slicer
* Month filter
* Market drill-down
* Profit target control

👉 Enables **self-service analytics**

---

## SQL Concepts Demonstrated

| Concept               | Where Used            |
| --------------------- | --------------------- |
| Filtering (`WHERE`)   | Market & time queries |
| Aggregation (`SUM`)   | Revenue calculations  |
| Grouping (`GROUP BY`) | Monthly/yearly trends |
| Date functions        | Time analysis         |
| Distinct values       | Product exploration   |

---

## Key Business Insights Unlocked

### Revenue Concentration

* Majority revenue from few markets
  → Risk of dependency

### Profitability Gaps

* High revenue ≠ high profit
  → Margin optimization needed

### Seasonal Trends

* Revenue drops in later months
  → Planning opportunity

### Customer Dependency

* Few customers dominate revenue
  → Strategic risk

---

## Why This Project Matters (Technical Depth)

This is not just a dashboard — it is a **complete analytics pipeline**.

### 1️⃣ SQL → Trust Layer

Ensures:

* Data accuracy
* Logical validation

---

### 2️⃣ Data Model → Performance Layer

* Star schema
* Efficient relationships

---

### 3️⃣ DAX → Intelligence Layer

* Context-aware calculations
* Business logic encoding

---

### 4️⃣ Dashboard → Decision Layer

* Interactive insights
* Executive-ready visuals

---

### Key Strength

> The project connects **raw data → business decision**, not just visualization.

---

## Getting Started

### Prerequisites

* MySQL
* Power BI Desktop

---

### Steps

```sql
-- Step 1: Explore data
SELECT * FROM transactions;

-- Step 2: Validate revenue
SELECT SUM(sales_amount) FROM transactions;
```

---

### Power BI

1. Import dataset
2. Build relationships
3. Create DAX measures
4. Design dashboard

---

## 🏁 Conclusion

This project demonstrates:

✔ End-to-end analytics thinking
✔ Strong SQL + BI integration
✔ Real-world business problem solving

