# Airline-Flight-Data-Analysis-Project
# ✈️ Airline Flight Data Analysis Project

A **complete, end-to-end SQL Data Analysis project** where raw airline flight data is cleaned, normalized, and analyzed to extract meaningful insights about **airlines, airports, routes, and passenger traffic**.

This project demonstrates **strong SQL fundamentals, database design skills, and analytical thinking**, making it ideal for **LinkedIn showcases, GitHub portfolios, and Data Analyst interviews**.

---

## 📌 Project Objective

The original dataset was provided as a **single raw table (`meta_data`)**, containing mixed information about airlines, airports, routes, dates, and passenger metrics.

### 🎯 Goals of the Project

* Design a **well-structured relational database**
* Convert raw data into **fact and dimension tables**
* Ensure **data integrity using keys and constraints**
* Write **analytical SQL queries** to uncover business insights
* Build a **portfolio-ready SQL project**

---

## 🗂️ Database Design (3NF)

The database is designed following **Third Normal Form (3NF)** to reduce redundancy and improve query efficiency.

### 📘 Dimension Tables

* **airline** – Airline master details
* **airport** – Airport and geographic information
* **city** – City and state-level attributes

### 📕 Fact Tables

* **flight** – Flight-level transactional data (routes, dates)
* **flightmetrics** – Passengers, freight, and mail statistics

### 🔗 Relationships

* One **airline** ➝ many **flights**
* One **airport** ➝ many **origin & destination flights**
* One **flight** ➝ one **metrics record**

---

## 🛠️ Tools & Technologies Used

* **MySQL**
* **SQL (JOINs, GROUP BY, Aggregations, Subqueries)**
* **Relational Database Design**
* **Data Cleaning & Transformation**
* **Analytical Query Writing**

---

## 🔄 Data Cleaning & Preparation

Key data preparation steps included:

* Renaming the raw table to `meta_data`
* Splitting raw data into **normalized tables**
* Removing duplicates using `DISTINCT`
* Correcting datatype issues (TEXT ➝ numeric)
* Separating **origin and destination airports**
* Applying **primary keys and foreign key constraints**

---

## 📊 Analysis Performed

### 1️⃣ Airport Analysis

* Busiest origin airports
* Busiest destination airports
* Airports ranked by total passenger traffic

### 2️⃣ Airline Performance

* Passenger share by airline
* Airline comparison based on traffic volume

### 3️⃣ Route Analysis

* Most frequently traveled routes
* Origin–destination city pair analysis

### 4️⃣ Time-Series Trends

* Year-wise passenger trends
* Month-wise passenger trends
* Seasonal travel patterns

### 5️⃣ Distance-Based Analysis

* Passenger distribution across distance groups
* Identification of high-demand distance ranges

---

## 🧠 Sample SQL Query

```sql
SELECT a.city_name,
       SUM(fm.passengers) AS total_passengers
FROM flight f
JOIN flightmetrics fm ON fm.flight_id = f.flight_id
JOIN airport a ON a.airport_id = f.dest_airport_id
GROUP BY a.city_name
ORDER BY total_passengers DESC;
```

**Insight:** Identifies the busiest destination cities based on passenger volume.

---

## 📈 Key Insights

* A small number of airports handle the majority of passenger traffic
* Certain airlines dominate overall passenger volume
* Passenger demand follows **clear seasonal patterns**
* Medium-distance flights carry higher average passengers

---

## 📁 Repository Structure

```
Flight-Data-Analysis/
│
├── SQL/
│   ├── table_creation.sql
│   ├── data_insertion.sql
│   └── analysis_queries.sql
│
├── Presentation/
│   └── Airline_Flight_Data_Analysis_Enhanced.pptx
│
├── README.md
```

---

## 🚀 Future Enhancements

* Build **interactive dashboards** using Power BI / Tableau
* Implement **window function–based analysis**
* Perform **predictive analysis** on passenger trends
* Optimize queries using **advanced indexing techniques**

---

## 👤 Author

**Shubham Chouhan**
Aspiring Data Analyst
Skills: SQL | Data Analysis | Database Design

📌 *If you find this project useful, feel free to ⭐ the repository!*
