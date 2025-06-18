# 📊 Global Layoffs Data Cleaning & Analysis (2020–2023)

Welcome to my hands-on SQL data cleaning and analysis project based on global tech layoffs from 2020 to 2023. This project is part of my Data Analytics Bootcamp, where I take raw, messy datasets and transform them into analysis-ready tables — paving the way for strategic insights through Exploratory Data Analysis (EDA).

---

## 🧼 Phase 1: Data Cleaning with SQL

In this stage, I performed the following core cleaning steps using MySQL:

1. **Removing Duplicates**  
   → Ensured each record is unique by using `ROW_NUMBER()` and deleting redundant entries.

2. **Standardizing Data**  
   → Trimmed whitespace, unified inconsistent naming (e.g., "Crypto Currency" → "Crypto"), and corrected country/language inconsistencies.

3. **Handling NULL or Blank Values**  
   → Replaced missing values with reliable estimates where possible using self-joins, and marked unfixable rows for deletion.

4. **Adjusting Data Types**  
   → Converted date columns from text to `DATE` format for better temporal analysis.

5. **Dropping Irrelevant Rows or Columns**  
   → Removed incomplete or unusable rows and dropped helper columns like `row_num`.

✅ **Result:** A clean, consistent dataset (`layoffs_staging2`) that is now fully prepped for analysis.

---

## 📈 Phase 2 (Coming Soon): Exploratory Data Analysis

The next phase will focus on uncovering:
- Layoff trends by year and region
- Industries and stages most affected
- Correlation between funding and layoffs
- And more business-relevant insights

Stay tuned!

---

## 🔗 Data Source

This dataset was introduced as part of my Data Analytics Bootcamp curriculum and is originally sourced from the public Alex The Analyst GitHub repository, which tracks global tech layoffs from 2020 to 2023.

🔍 Original Dataset:  
https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv

---

## 📂 SQL Scripts & Documentation

All queries, logic, and cleaning steps are fully documented in the following SQL file:  
`📄 layoffs_cleaning.sql`

You can explore the entire project on my GitHub repository here:  
👉 https://github.com/michaelvincentsebastian/data-analytics-projects.git

---

## 💡 About Me

I'm Michael Vincent, an aspiring Data Analyst with a passion for solving business problems using data. I’m currently building my portfolio through hands-on projects like this to demonstrate my analytical thinking and SQL proficiency.

Let’s connect on [LinkedIn](https://www.linkedin.com/in/michaelvincentsebastian/)!
