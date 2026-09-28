# 🏢 Northwind Enterprise Data Warehouse & Interactive Power BI Dashboard

## 📌 Executive Summary
This project is an **End-to-End Business Intelligence and Data Warehousing solution** built on the classic **Northwind** dataset. 

The project transforms raw transactional OLTP data into an optimized **Data Warehouse (Star Schema)** using SQL, followed by building a 4-page interactive **Power BI Dashboard** to deliver actionable insights across Sales, Customers, Employees, and Inventory performance.

---

## 🏗️ Architecture & Tech Stack
* **Database & Warehousing**: SQL Server / SSMS (Data Modeling, DDL, DML, ETL Views)
* **Data Modeling**: Entity Relationship Diagram (ERD), Dimensional Modeling (Star Schema)
* **Visualization & Analytics**: Microsoft Power BI Desktop
* **Analytics Language**: DAX (Data Analysis Expressions) for complex business logic & KPIs

---

## 📐 Data Warehouse & ERD Design

### 1. Relational to Dimensional Transformation
* Transformed OLTP normalized tables into a **Star Schema** architecture optimized for analytical queries (OLAP).
* Implemented central **Fact Tables** (`Fact_Orders` / `Order Details`) surrounded by dedicated **Dimension Tables**:
  * `DIM_Customer`
  * `DIM_Employee`
  * `DIM_Product`
  * `DIM_Date`
  * `DIM_Shipper` / `DIM_Region`

*(Tip: Insert your ERD Diagram image here if available)*  
`![ERD Schema](images/erd_diagram.png)`

---

## 📊 Dashboard Breakdown

### 1. Employee Performance Page
* **Executive KPIs**: Total Orders, Total Revenue ($1.34M), Inventory Status, and Order Units.
* **Employee Contribution**: Evaluates revenue generation per employee (Top performers: Margaret & Nancy).
* **Geographic Spread**: Tracks employee distribution across regions.

![Employee Performance](images/01_Employee_Performance.png)

---

### 2. Customer Insights Page
* **Global Footprint**: Customer count and revenue breakdown by country (USA and Germany leading).
* **Key Accounts**: Identifies top revenue-generating corporate accounts.

![Customer Insights](images/02_Customer_Insights.png)

---

### 3. Order & Logistics Trends Page
* **Sales Trends**: Historical sales performance across multiple years.
* **Shipper Analysis**: Order distribution across logistics partners (Federal Shipping, Speedy Express, United Package).

![Order Trends](images/03_Order_Trends.png)

---

### 4. Product & Inventory Management Page
* **Category Performance**: Sales performance dominated by *Beverages* and *Confections*.
* **Stock Optimization**: Monitors `Units in Stock` vs. `Units on Order` to prevent stockouts and overstocking.

![Product Inventory](images/04_Product_Inventory.png)

---

## 📂 Repository Structure
```text
├── 📁 data/                  # Raw SQL scripts, DDL/DML, and Star Schema creation scripts
├── 📁 docs/                  # ERD Diagram and Architecture Documentation
├── 📁 images/                # Dashboard Screenshots & Visual Assets
├── 📄 Northwind_Dashboard.pbix # Interactive Power BI File
└── 📄 README.md              # Project Documentation
