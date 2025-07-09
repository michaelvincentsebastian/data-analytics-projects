# 🕸️ Web Scraping Project: Top U.S. Companies by Revenue

This project is a simple and practical demonstration of web scraping using Python. The goal is to extract the list of the **largest companies in the United States by revenue** from Wikipedia, transform it into a structured format using **Pandas DataFrame**, and export it as a **CSV file** for further use.

## 🌐 Source Website

Data scraped from:
> [Wikipedia - List of largest companies in the United States by revenue](https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue)

## 🛠️ Tools & Libraries

- **Anaconda Navigator**
- **Jupyter Notebook**
- **Python 3.x**
- `BeautifulSoup` – for parsing HTML
- `requests` – for sending HTTP requests
- `pandas` – for handling tabular data

## 📌 Step-by-Step Process

1. **Import Libraries**  
   Load necessary Python libraries for web scraping and data processing.

2. **Request Web Page**  
   Send a GET request to the Wikipedia page and parse the HTML using BeautifulSoup.

3. **Locate Table**  
   Identify and extract the table with class `wikitable sortable`.

4. **Extract Header & Data**  
   Extract column headers and row data, clean text using `.strip()`, and store it in a list.

5. **Create DataFrame**  
   Create a Pandas DataFrame using the headers and populate it with row data.

6. **Export to CSV**  
   Save the DataFrame as a CSV file named `Top-Companies.csv`.

## 📁 Output

The final dataset is exported to:
```plaintext
C:\Users\Asus\Downloads\Web-Scrapping Project\Top-Companies.csv
