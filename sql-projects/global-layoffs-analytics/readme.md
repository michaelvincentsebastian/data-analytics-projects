# 📊 Global Layoffs Data Cleaning & Analysis (2020–2023)

This project presents an end-to-end data analytics workflow — from cleaning raw layoff data using **SQL**, to extracting meaningful insights through **Power BI**. Based on global tech layoffs from 2020 to 2023, I explored patterns across time, industries, geography, company stages, and funding levels.

---

## 🧼 Data Cleaning: Preparing Raw Data for Analysis

Before diving into the analysis, I first cleaned and standardized the dataset to ensure it was accurate and analysis-ready.

**Key Cleaning Steps (MySQL):**
- Removed duplicates using `ROW_NUMBER()`
- Trimmed and standardized inconsistent labels (e.g. `"Crypto Currency"` → `"Crypto"`)
- Replaced or removed NULL values via self-joins and filters
- Converted `TEXT` to `DATE` for time-based queries
- Dropped irrelevant helper columns

> 📁 File: `data_cleaning.sql`  
> ✅ Final Table: `data-after-cleaning.jpg` | `data-before-cleaning.jpg` (cleaned dataset)

---

## 📈 Exploratory Data Analysis (EDA)

After cleaning the data, I explored it using SQL queries and visualized the output using Power BI dashboards.

---

### 🔹 Part 1: General Summary

Core queries for understanding the dataset at a glance:
- Layoff time range (first & last event)
- Highest layoff numbers in a single event
- Companies with 100% layoffs
- Top 10 companies by layoffs count

📄 File: `eda-1.sql`  
📊 Visual: [`1_Essential-and-General-Summary-Dashboard.jpg`](./sql-projects/global-layoffs-analytics/result/1_Essential-and-General-Summary-Dashboard.jpg)

---

### 🔹 Part 2: Trend & Time Analysis

Understanding layoff trends over time:
- Total layoffs by year
- Monthly layoffs (2020–2023)
- Cumulative layoffs growth
- 3-month rolling average & sum

📄 File: `eda-2.sql`  
📊 Visual: [`2_Trend-Time-Analysis.jpg`](./sql-projects/global-layoffs-analytics/result/2_Trend-Time-Analysis.jpg)

---

### 🔹 Part 3: Company, Industry & Geography Insights

Exploring layoff distributions by various dimensions:
- Top industries with most layoffs
- Countries with highest layoffs
- Company stages (e.g., Series A, Public)
- Top 5 companies by layoffs (per year)

📄 File: `eda-3.sql`  
📊 Visual: [`3_Company-Industry-and-Geographic-Analysis.jpg`](./sql-projects/global-layoffs-analytics/result/3_Company-Industry-and-Geographic-Analysis.jpg)

---

### 🔹 Part 4: Strategic Insights & Final Dashboard

Deeper strategic breakdowns to support decision making:
- Top 3 industries per year (2020–2023)
- Layoffs categorized by funding levels
- Global yearly vs cumulative trend
- Layoff hotspots by HQ location
- Average layoff % per industry

📄 File: `eda-4.sql`  
📊 Visual: [`4_Comprehensive-Layoffs-Analysis-Dashboard.jpg`](./sql-projects/global-layoffs-analytics/result/4_Comprehensive-Layoffs-Analysis-Dashboard.jpg)

---

## 🔗 Dataset Source

The dataset is sourced from [Alex The Analyst’s GitHub repo](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv) and was used as part of my Data Analytics Bootcamp.

---

## 🧰 Tools Used

- **MySQL** (Data cleaning & transformation)  
- **Power BI** (Data visualization)  
- **VS Code** (SQL editing)  
- **Git & GitHub** (Version control & documentation)

---

## ✅ Project Status: Complete

This project demonstrates my ability to clean messy data, write meaningful SQL queries, and build strategic dashboards that tell a clear business story.

---

## 🙋‍♂️ About Me

I'm **Michael Vincent**, an aspiring Data Analyst passionate about transforming raw data into actionable insights. This project reflects my dedication to building strong analytical foundations through hands-on work.

📎 [Connect with me on LinkedIn](https://www.linkedin.com/in/michaelvincentsebastian)
