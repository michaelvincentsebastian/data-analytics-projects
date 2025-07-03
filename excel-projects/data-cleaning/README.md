# Data Cleaning with Microsoft Excel

This project demonstrates a simple yet effective approach to cleaning raw data using Microsoft Excel.

## 📁 Project Structure
📦 data-cleaning/
├── raw_data.xlsx # Original dataset (unprocessed)
└── cleaned_data.xlsx # Cleaned dataset after Excel processing


## 🧹 Cleaning Process

All cleaning steps were done using built-in Excel functions and tools. Below is the summary of steps taken:

- **Remove Duplicates:** Used `Remove Duplicates` feature to eliminate redundant entries.
- **Standardize Text Formatting:**
  - Converted names/text using `=UPPER()`, `=LOWER()`, and `=PROPER()` as needed.
- **Filter & Manual Inspection:**
  - Applied filters to find and correct spelling inconsistencies.
- **Remove Extra Spaces:**
  - Used `=TRIM()` to remove leading/trailing spaces in cells.
- **Format Numerical Data:**
  - Adjusted date and currency fields for better readability and consistency.

## 💡 Tools Used

- Microsoft Excel (Desktop Version)

## 📌 Notes

For small to medium-sized datasets, Excel offers an intuitive and fast way to perform data cleaning without the need for SQL queries or scripts. However, for large-scale datasets or automation, SQL or Python-based tools are recommended.

---

### 📷 [View Cleaned Dataset](./excel-projects/data-cleaning/cleaned-data.png)
### 🔗 [Cleaned Dataset Spreadsheet](./excel-projects/data-cleaning/cleaned_data.xlsx)
