# 🛒 E-Commerce Customer Analytics

An end-to-end data analytics project focused on understanding **e-commerce sales performance, customer behavior, product performance, and returns** using transaction-level retail data.

The project covers the complete analytics workflow — from **raw data preparation and cleaning to SQL analysis, Power BI data modeling, DAX measures, dashboard development, and business insights**.

**Tools:** Excel • SQL Server • Power BI • DAX

---

## 📊 Project Overview

The goal of this project was to analyze an online retail dataset and answer practical business questions such as:

- How much revenue is the business generating?
- How is revenue changing over time?
- Which countries contribute the most revenue?
- Which products generate the most revenue?
- Which products sell the highest number of units?
- Who are the highest-value customers?
- How many customers are repeat customers?
- How is customer spending distributed?
- Which products have relatively poor revenue performance?
- How significant are product returns?

The final result is an interactive Power BI dashboard divided into **Executive Overview, Customer Analysis, and Product Analysis**.

---

# 📈 Dashboard

## Executive Overview

<img width="1755" height="970" alt="Screenshot (188)" src="https://github.com/user-attachments/assets/251a6e56-3bf0-4a7d-9fdf-cf2faa5802e1" />

The Executive Overview provides a high-level summary of the business.

It includes key KPIs such as:

- Net Revenue
- Total Orders
- Total Customers
- Average Order Value
- Repeat Customer %
- Return Rate

The page also provides:

- Monthly revenue trends
- Revenue by country
- Top countries by revenue
- Top products by revenue
- Interactive filters for year, month, country, and transaction type

This page is designed to give a quick understanding of the overall business performance.

---

## Customer Analysis

<img width="1762" height="993" alt="Image" src="https://github.com/user-attachments/assets/7475fcf1-bd6f-4e6d-b693-3e593d1aafec" />

The Customer Analysis page focuses on customer value and purchasing behavior.

It includes:

- Total customer count
- Repeat customer percentage
- Revenue per customer
- Total orders
- One-time vs repeat customer analysis
- Top customers by revenue
- Customer revenue distribution

Customers are grouped into revenue bands to understand how the customer base is distributed across different spending levels.

This helps identify **high-value customers and the proportion of customers who return to purchase again**.

---

## Product Analysis

<img width="1763" height="986" alt="Image" src="https://github.com/user-attachments/assets/03a4c1ca-7ab1-406d-9767-b8e1c2fcac1e" />

The Product Analysis page focuses on product-level performance.

It includes:

- Total number of products
- Net revenue
- Total units sold
- Average order value
- Top products by revenue
- Top products by units sold
- Revenue vs units sold comparison
- Lowest-revenue products

The comparison between revenue and units sold helps identify products that may have **high sales volume but lower revenue**, or products that generate high revenue despite selling fewer units.

---

# 🗂️ Dataset

The project uses an online retail transaction dataset containing individual purchase records.

Important fields include:

| Column | Description |
|---|---|
| InvoiceNo | Unique invoice/order identifier |
| StockCode | Product identifier |
| Description | Product description |
| Quantity | Number of units purchased |
| InvoiceDate | Date and time of transaction |
| UnitPrice | Price per unit |
| CustomerID | Customer identifier |
| Country | Customer's country |

Additional fields were created during data preparation:

- **Transaction_Type** — classifies transactions as Sale or Return
- **Revenue** — calculated as Quantity × UnitPrice

---

# 🧹 Data Cleaning & Preparation

Before performing the analysis, the dataset was reviewed and cleaned to improve data quality.

### Cleaning steps included:

- Checking the structure and data types of the dataset
- Identifying duplicate records
- Removing exact duplicate rows
- Checking missing values
- Reviewing invalid quantities
- Reviewing invalid unit prices
- Converting transaction dates into a usable date/time format
- Creating transaction type classification
- Creating the revenue column
- Validating the cleaned dataset after transformation

Rows with invalid transaction values such as **non-positive quantities or unit prices** were removed from the cleaned analysis table.

Missing Customer IDs were not artificially replaced because doing so could create incorrect customer-level analysis. These records can still contribute to overall sales analysis but are excluded from customer-specific calculations where a customer ID is required.

The original raw dataset was kept unchanged, while analysis was performed on the cleaned dataset.

---

# 🔍 Exploratory Data Analysis

SQL was used to perform the initial business analysis after cleaning the data.

The analysis covered:

### Sales Performance
- Total revenue
- Total orders
- Average order value
- Revenue by month
- Revenue trends over time

### Customer Analysis
- Total unique customers
- Customer revenue
- Top customers by revenue
- Repeat vs one-time customers
- Revenue distribution across customers

### Product Analysis
- Top products by revenue
- Top products by units sold
- Lowest-revenue products
- Revenue vs sales volume

### Geographic Analysis
- Revenue by country
- Number of customers by country
- Number of orders by country
- Country revenue contribution

This SQL analysis was used to understand the dataset and identify the metrics and visualizations that would be most useful in Power BI.

---

# 🧮 Power BI & DAX

After the SQL analysis, the cleaned dataset was imported into Power BI for interactive reporting.

DAX measures were created for the main business KPIs.

Some of the key measures include:

- Net Revenue
- Sales Revenue
- Return Value
- Total Orders
- Total Customers
- Average Order Value
- Return Orders
- Return Rate
- Total Units Sold
- Revenue per Customer
- Total Products
- Revenue Growth %
- Repeat Customers
- Repeat Customer %

Additional calculated logic was used for:

- One-time vs repeat customer classification
- Customer revenue bands
- Revenue contribution analysis
- Product performance comparisons

---

# 🎯 Business Questions

The analysis was built around practical business questions rather than simply creating charts.

### Sales

- What is the overall revenue?
- How does revenue change over time?
- What is the average order value?
- Which countries generate the most revenue?

### Customers

- How many unique customers are there?
- How many customers are repeat customers?
- Who are the highest-value customers?
- How is customer revenue distributed?

### Products

- Which products generate the most revenue?
- Which products sell the most units?
- Do high-volume products also generate high revenue?
- Which products have relatively low revenue?

### Returns

- How many orders are returned?
- What is the value of returned transactions?
- What percentage of orders are returns?

---

# 💡 Key Insights

The dashboard can be used to identify several important business patterns.

### 🌍 Geographic concentration

Revenue is heavily concentrated in the **United Kingdom**, making it the most important market in the dataset.

This suggests that the business has a strong dependence on its primary market and could potentially explore opportunities to increase revenue in other countries.

### 👥 Customer value

Customers contribute very differently to overall revenue.

A relatively small group of high-value customers can account for a significant portion of sales, making customer retention and targeted engagement important areas for further analysis.

### 🔁 Customer retention

The one-time vs repeat customer analysis helps determine how much of the customer base comes back to purchase again.

A higher repeat customer rate can indicate stronger customer retention and provides an opportunity to investigate what drives repeat purchases.

### 📦 Product performance

Revenue and units sold do not always tell the same story.

Some products may sell large quantities but generate comparatively lower revenue, while other products can generate substantial revenue with fewer units sold.

Comparing both metrics provides a better understanding of product performance than using either metric alone.

### ↩️ Returns

Return analysis provides another perspective on sales performance by showing how much transaction value is associated with returned orders.

A high return rate for particular products or markets could be investigated further to identify potential product or customer experience issues.

---

# 🎯 Business Recommendations

Based on the patterns identified through the analysis, the business could consider the following actions:

### 🌍 Strengthen the core market while exploring new markets

Since the **United Kingdom contributes the majority of revenue**, the business should continue maintaining strong inventory availability and customer service in this market.

At the same time, countries with existing sales activity could be evaluated to identify markets with potential for further growth.

### 👥 Improve customer retention

The business could target **one-time customers** with personalized offers, product recommendations, email campaigns, bundles, or loyalty incentives to encourage repeat purchases.

Increasing repeat purchases can help improve customer lifetime value without relying entirely on acquiring new customers.

### ⭐ Focus on high-value customers

High-revenue customers should be identified and monitored as an important customer segment.

The business could consider loyalty benefits, personalized recommendations, early access to products, or targeted promotions to strengthen relationships with these customers.

### 📦 Review product performance

Low-revenue products should be investigated to understand whether the issue is related to low demand, pricing, product positioning, or limited visibility.

Depending on the findings, the business could consider **improving, repositioning, bundling, discounting, or eventually discontinuing** consistently underperforming products.

### 💰 Analyze high-volume but lower-revenue products

Products with high unit sales but relatively low revenue should be reviewed for pricing, discounts, and profitability.

High sales volume does not necessarily mean high business value, so revenue and, ideally, profit margin should be considered together when making product decisions.

### ↩️ Investigate returns

Products or markets showing unusually high return activity should be investigated further.

Possible areas to examine include product quality, product descriptions, customer expectations, sizing, packaging, and fulfillment issues.

Reducing unnecessary returns could improve both customer experience and overall business performance.

---

# 🛠️ Tools & Technologies

### Excel
Used for initial data preparation and creating additional fields before loading the data into SQL Server.

### SQL Server / SSMS
Used for:

- Data cleaning
- Data validation
- Exploratory data analysis
- Aggregations
- Customer analysis
- Product analysis
- Geographic analysis
- Business KPI calculations

### Power BI
Used for:

- Data modeling
- Interactive dashboards
- Data visualization
- Filters and slicers
- Business reporting

### DAX
Used to create calculated measures and analytical logic for:

- Revenue
- Orders
- Customers
- AOV
- Returns
- Customer retention
- Product performance
- Revenue growth

---

# 🔄 End-to-End Workflow

```text
Raw Dataset
     ↓
Initial Data Preparation
     ↓
Data Cleaning
     ↓
Data Validation
     ↓
SQL Exploratory Analysis
     ↓
Power BI Data Model
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights & Recommendations
```

The project follows a complete analytics workflow rather than focusing only on dashboard creation.

---

# 📌 Project Outcome

This project demonstrates the ability to take a raw transaction dataset and turn it into a structured business analysis.

The main skills demonstrated include:

- Data cleaning
- Data validation
- SQL querying
- Exploratory data analysis
- Business KPI development
- Customer segmentation
- Product performance analysis
- Data visualization
- Power BI dashboard development
- DAX calculations
- Business insight generation

⭐ If you find this project useful, feel free to explore the dashboard and SQL analysis included in the repository.



