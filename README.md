# 🛒 E-Commerce Funnel Analysis | SQL + Power BI


## 📌 Project Overview

This project analyzes an **e-commerce customer funnel** to understand how users move through different stages of the purchasing journey — from visiting the website to completing a purchase.

The analysis uses **SQL for data exploration and business analysis** and **Power BI for interactive dashboard visualization**.

### 🎯 Business Objective

The main objective is to identify:

* How many users enter each funnel stage
* Where users drop off during the purchasing journey
* Overall conversion rate
* Device-wise purchasing behavior
* Traffic/referral source performance
* Country-wise conversion performance
* Monthly purchase trends
* Relationship between cart size and conversion
* Average time users spend on different pages

---

# 🔄 E-Commerce Funnel

The customer journey analyzed in this project is:

```text
Visit
   ↓
Product Page
   ↓
Cart
   ↓
Checkout
   ↓
Purchase
```

The final **confirmation page** is treated as the purchase/conversion event.

---

# 📂 Project Files

| File                        | Description                                       |
| --------------------------- | ------------------------------------------------- |
| `FunnelDataset.csv`         | Raw e-commerce funnel dataset                     |
| `FUNNEL-ANALYSIS-SQL.sql`   | SQL queries used for funnel and customer analysis |
| `Funnel_Dashboard (1).pbix` | Power BI dashboard file                           |
| `Funnel_Dashboard_PDF.pdf`  | Exported PDF version of the Power BI dashboard    |

---

# 📊 Dataset Description

The dataset contains **12,719 records** and **10 columns**.

| Column               | Description                               |
| -------------------- | ----------------------------------------- |
| `SessionID`          | Unique session identifier                 |
| `UserID`             | Unique customer/user identifier           |
| `Timestampp`         | Date and time of the user event           |
| `PageType`           | Page/stage visited by the user            |
| `DeviceType`         | Device used by the customer               |
| `Country`            | Customer's country                        |
| `ReferralSource`     | Source through which the customer arrived |
| `TimeOnPage_seconds` | Time spent on the page in seconds         |
| `ItemsInCart`        | Number of items added to cart             |
| `Purchased`          | Purchase indicator                        |

### Dataset Characteristics

* **Rows:** 12,719
* **Columns:** 10
* **Unique Users:** 1,872
* **Unique Sessions:** 5,000
* **Countries:** 7
* **Device Types:** 3
* **Referral Sources:** 4
* **Page Types:** 5
* **Missing Values:** None

---

# 🛠️ Tools & Technologies

### SQL

SQL was used for:

* Data validation
* Data exploration
* Funnel analysis
* Conversion-rate calculation
* Drop-off analysis
* Device-wise analysis
* Referral-source analysis
* Country-wise analysis
* Cart behavior analysis
* Time-spent analysis

### Power BI

Power BI was used to create the interactive dashboard and visualize:

* Funnel drop-off
* Conversion rate
* Traffic by country
* Traffic source contribution
* Monthly confirmed orders
* Device-wise purchase distribution

---

# 🧮 SQL Analysis

The SQL script includes several analytical sections.

### 1. Data Validation

Basic checks were performed to understand:

* Total rows
* Total users
* Total sessions
* Available funnel stages

### 2. Overall Funnel Analysis

The number of unique users was calculated at each stage:

```text
Visit → Product → Cart → Checkout → Purchase
```

### 3. Conversion Rate

Overall conversion was calculated using:

```text
Conversion Rate =
Converted Users / Total Users × 100
```

### 4. Funnel Drop-Off

Drop-off was calculated between consecutive funnel stages to identify where users were leaving the purchasing journey.

### 5. Device-Wise Funnel Analysis

The analysis compares:

* Mobile
* Tablet
* Desktop

across the funnel stages.

### 6. Referral Source Analysis

The project evaluates conversion performance from:

* Google
* Social Media
* Direct
* Email

### 7. Country-Wise Analysis

Conversion behavior was analyzed across different countries.

### 8. Time-on-Page Analysis

Average time spent on each page type was calculated.

### 9. Cart Size vs Conversion

The analysis examines whether users with more items in their cart have a higher probability of purchasing.

---

# 📈 Power BI Dashboard

The dashboard provides an executive-level view of the e-commerce funnel.

## Key Dashboard Metrics

According to the dashboard:

| KPI             |  Value |
| --------------- | -----: |
| Total Users     |    709 |
| Purchased Users |    160 |
| Conversion Rate | 22.57% |

### Funnel Performance

| Funnel Stage | Users |
| ------------ | ----: |
| Visit        |   709 |
| Product      |   582 |
| Cart         |   259 |
| Checkout     |   180 |
| Purchase     |   160 |

The largest funnel reduction occurs between the **Product** and **Cart** stages, highlighting an important area for further investigation.

---

# 🌍 Traffic by Country

The dashboard analyzes traffic across:

* UK
* USA
* Australia
* France
* Canada
* Germany
* India

This helps identify geographical differences in customer traffic and purchasing behavior.

---

# 📢 Traffic Source Contribution

The dashboard compares four major traffic sources:

* Google
* Social Media
* Direct
* Email

This analysis can help businesses understand which acquisition channels contribute the most users and potential customers.

---

# 📱 Device-Wise Purchase Distribution

Purchase distribution is analyzed across:

* Mobile
* Tablet
* Desktop

Dashboard results show:

| Device  | Purchases |
| ------- | --------: |
| Mobile  |       315 |
| Tablet  |       280 |
| Desktop |       225 |

This provides insight into how customers interact with the e-commerce platform across different devices.

---

# 📅 Monthly Purchase Analysis

The dashboard includes month-wise confirmed orders from:

**January 2025 → August 2025**

This allows businesses to identify changes in purchasing activity over time and compare performance across quarters.

---

# 💡 Key Business Insights

Based on the dashboard analysis:

### 1. Significant Funnel Drop-Off

The customer journey decreases from **709 visitors to 160 purchasers**, resulting in an overall conversion rate of approximately **22.57%**.

### 2. Product-to-Cart Stage Requires Attention

The largest reduction occurs between the product and cart stages:

```text
582 Product Users
        ↓
259 Cart Users
```

This suggests an opportunity to investigate product-page experience, pricing, product information, CTAs, and customer hesitation.

### 3. Checkout-to-Purchase Performance

The funnel shows:

```text
180 Checkout Users
        ↓
160 Purchasers
```

A relatively high proportion of checkout users complete the purchase, suggesting that the checkout stage performs better than earlier funnel stages.

### 4. Device Behavior

The dashboard provides a device-level view of purchases, allowing businesses to identify which platforms require optimization.

### 5. Marketing Channel Analysis

Traffic-source analysis can help prioritize acquisition channels and identify opportunities to improve conversion from lower-performing sources.

---

# 📷 Dashboard Preview

The Power BI dashboard contains:

* Funnel visualization
* KPI cards
* Country analysis
* Traffic source contribution
* Monthly confirmed orders
* Device-wise purchase distribution
* Date and category filters

You can view the exported dashboard in:

`Funnel_Dashboard_PDF.pdf`

---

# 🚀 How to Reproduce the Project

## Step 1 — Download the Repository

Clone the repository:

```bash
git clone https://github.com/yourusername/ecommerce-funnel-analysis.git
```

Navigate into the project:

```bash
cd ecommerce-funnel-analysis
```

## Step 2 — Load the Dataset

Use:

```text
FunnelDataset.csv
```

Import the dataset into your SQL database.

## Step 3 — Run SQL Analysis

Open:

```text
FUNNEL-ANALYSIS-SQL.sql
```

Execute the queries in your SQL environment.

The script creates the `funnel_analysis` database and performs the required funnel analysis.

## Step 4 — Open Power BI Dashboard

Open:

```text
Funnel_Dashboard (1).pbix
```

in **Power BI Desktop**.

Connect the dashboard to the dataset/database if required.

## Step 5 — Explore the Dashboard

Use the available filters to analyze:

* Country
* Device
* Date
* Funnel stage
* Traffic source

---

# 📁 Suggested Repository Structure

```text
E-Commerce-Funnel-Analysis/
│
├── 📂 Dataset/
│   └── FunnelDataset.csv
│
├── 📂 SQL/
│   └── FUNNEL-ANALYSIS-SQL.sql
│
├── 📂 PowerBI/
│   └── Funnel_Dashboard.pbix
│
├── 📂 Dashboard/
│   └── Funnel_Dashboard_PDF.pdf
│
└── README.md
```

---

# 🎓 Skills Demonstrated

This project demonstrates practical skills in:

* SQL
* Data Cleaning & Validation
* Exploratory Data Analysis
* Funnel Analysis
* Conversion Rate Analysis
* Customer Behavior Analysis
* Business Analytics
* Power BI
* Data Visualization
* KPI Development
* Business Insights
* Dashboard Design

---

# 💼 Business Use Case

An e-commerce company can use this analysis to answer questions such as:

> **Where are customers dropping out of the purchasing journey?**

> **Which traffic sources generate the most valuable users?**

> **Which devices have the highest purchase activity?**

> **Which countries show stronger conversion behavior?**

> **At which stage should the company focus its optimization efforts?**

These insights can support decisions around **website optimization, marketing campaigns, UX improvements, and conversion-rate optimization (CRO).**

---

# 🔮 Future Improvements

Possible future enhancements include:

* Add customer lifetime value analysis
* Analyze repeat purchases
* Add revenue and profit metrics
* Create cohort analysis
* Add customer segmentation
* Analyze funnel performance by marketing campaign
* Build automated Power BI refresh
* Add predictive conversion modeling using Python
* Create an executive KPI dashboard
* Add statistical analysis of conversion drivers

---

# 👩‍💻 Author

**Kriti Srivastava**

Aspiring Data Analyst | SQL | Python | Excel | Power BI

### Project Focus

**E-Commerce Funnel Analysis using SQL & Power BI**
**CONNECT WITH ME - www.linkedin.com/in/kriti-srivastava14**
---

⭐ If you found this project useful, consider giving the repository a **star**!
