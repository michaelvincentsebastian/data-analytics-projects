# 💼 Workforce Intelligence Dashboard: Salary, Demographics & Strategic Role Insights

This project demonstrates how SQL and Power BI can be used to uncover key insights from employee data related to salary fairness, gender diversity, departmental dynamics, and strategic leadership roles.

> 🎯 **Goal**: Turn raw HR data into strategic insights that inform data-driven decisions in workforce planning and compensation analysis.

---

## 📌 Key Highlights

1. **Are prestigious roles always well-paid?**  
   → Analyzed average salary by occupation to detect underpaid positions.

2. **Data quality audit for missing department info**  
   → Checked for employees without assigned departments.

3. **Gender distribution across departments**  
   → Evaluated diversity metrics and potential imbalances.

4. **Average age and salary per department**  
   → Mapped compensation against age to identify trends.

5. **Top 3 highest-paid employees**  
   → Used window function `RANK()` to handle salary ties.

6. **Strategic leadership demographic breakdown**  
   → Filtered "Director", "Manager", "Planner" roles to assess gender & age representation.

---

## 🧠 Dataset Overview

- **employee_salary**: Contains salary, department ID, and job title.
- **employee_demographics**: Includes age and gender of employees.
- **parks_departments**: Maps department IDs to department names.

---

## 🛠️ Tools & Tech Stack

| Tool                 | Usage                            |
|----------------------|----------------------------------|
| **SQL (PostgreSQL)** | Data exploration and cleaning    |
| **Power BI**         | Dashboard visualization          |
| **GitHub**           | Version control & documentation  |

---

## 📈 Visualizations in Power BI

Each insight is visualized using the most appropriate chart type:

| Insight                                       | Chart Type               |
|----------------------------------------------|--------------------------|
| Salary by Occupation                         | Clustered Bar Chart      |
| Missing Department Data                      | Table + KPI Card         |
| Gender per Department                        | Stacked Column Chart     |
| Avg Age & Salary by Department               | Combo Chart (Line + Bar) |
| Top 3 Salaries                               | Table with Ranking       |
| Strategic Role Demographics                  | Bar Chart + Line Chart   |

---

## 💡 Why I Built This

In an era where data drives strategy, I wanted to practice how to derive impactful business insights from real-world datasets. This dashboard not only enhances my analytical thinking but also demonstrates how I can turn raw data into valuable stories.

By building this, I aim to show that:
- I can connect data to business goals
- I understand how to communicate insights visually
- I care about data quality, fairness, and representation
