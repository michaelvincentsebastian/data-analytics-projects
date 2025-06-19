# 📊 Global Layoffs Data Cleaning & Analysis (2020–2023)

Welcome to my hands-on SQL data cleaning and analysis project based on global tech layoffs from 2020 to 2023. This project is part of my Data Analytics Bootcamp, where I take raw, messy datasets and transform them into analysis-ready tables — paving the way for strategic insights through Exploratory Data Analysis (EDA).

---

## 🧼 Phase 1: Data Cleaning with SQL

In this stage, I performed the following core cleaning steps using **MySQL**:

1. **Removing Duplicates**  
   → Ensured each record is unique using `ROW_NUMBER()` and deleted redundant entries.

2. **Standardizing Data**  
   → Trimmed whitespaces, unified inconsistent naming (e.g., `"Crypto Currency"` → `"Crypto"`), and corrected country/language typos.

3. **Handling NULL or Blank Values**  
   → Used self-joins to fill in missing data where possible, and removed rows that couldn’t be salvaged.

4. **Adjusting Data Types**  
   → Converted `date` from `TEXT` to `DATE` format to enable proper temporal analysis.

5. **Dropping Irrelevant Rows or Columns**  
   → Removed incomplete records and dropped helper columns like `row_num`.

✅ **Result:** A clean, structured dataset (`layoffs_staging2`) that is ready for further analysis.

> 📄 File: `layoffs_cleaning.sql`

---

## 📈 Phase 2: Exploratory Data Analysis (EDA)

In this phase, I explored the cleaned data using structured SQL queries and visualized the output using **Power BI**.

### 🔹 Part 1: Essential & General Summary Queries
- Layoff time range (first & last date)
- Maximum layoffs per event
- Companies with 100% layoffs
- Top 10 companies by total layoffs

> 📄 File: `layoffs_eda_summary_queries.sql`  
> 📊 Visual: [`dashboard-essential&general-summary-queries.jpg`](./dashboard-essential&general-summary-queries.jpg)

**Tools Used:**
- MySQL  
- Power BI  
- Git & GitHub  
- VS Code  

🔜 Upcoming EDA Parts:
- **Part 2:** Trend & Time Analysis  
- **Part 3:** In-Depth by Industry, Country, Company Stage  
- **Part 4:** Advanced Insights (e.g., rolling average, industry-year breakdown, funding vs layoffs)

---

## 🔗 Data Source

This dataset was introduced as part of my Data Analytics Bootcamp curriculum and is originally sourced from the public Alex The Analyst GitHub repository, which tracks global tech layoffs from 2020 to 2023.

🔍 Original Dataset:  
[AlexTheAnalyst - layoffs.csv](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)

---

## 📂 SQL Scripts & Documentation

Explore the full SQL logic and analysis process in my GitHub repository:  
👉 https://github.com/michaelvincentsebastian/data-analytics-projects

---

## 💡 About Me

I'm **Michael Vincent**, an aspiring Data Analyst with a passion for turning raw data into actionable business insights. Through hands-on projects like this, I aim to demonstrate my skills in SQL, EDA, and data storytelling.

Let’s connect on [LinkedIn](https://www.linkedin.com/in/michaelvincentsebastian/)!
