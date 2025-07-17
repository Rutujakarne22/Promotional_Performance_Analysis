# Promotional_Performance_Analysis

---
##  Overview
This project presents a comprehensive **promotional performance analysis** for **AtliQ Mart**, a supermarket chain operating in southern India. The goal is to evaluate the performance of festive season promotions (Diwali 2023 and Sankranti 2024) using real-world Excel-based MIS reporting and MySQL-driven data insights.

---

##  Problem Statement

AtliQ Mart, a large supermarket chain operating across South India, launched promotional campaigns during the Diwali 2023 and Sankranti 2024 festivals to boost product sales and brand visibility. Post-campaign, the Sales Director seeks a detailed yet quick performance analysis to understand which promotions performed well, which stores drove higher revenue, and how different product categories responded to these offers. This analysis is crucial for making data-driven decisions for upcoming promotional strategies.

---

##  Objective

The goal of this project is to analyze the effectiveness of AtliQ Mart’s festive promotional campaigns using Microsoft Excel and MySQL. The project focuses on evaluating revenue growth, unit sales uplift, store and city-level performance, and the impact of various promotion types. By combining dashboarding in Excel with SQL-based insights, the objective is to deliver actionable recommendations that help the business refine future campaigns and maximize ROI.

---

##  Data Sources Used

The following 4 files were used, forming a star-schema database:

| Table Name       | Description |
|------------------|-------------|
| `fact_events.csv`      | Sales events with campaign, price, quantity (before/after promo), and promo type |
| `dim_campaigns.csv`    | Details of each campaign (name, start date, end date) |
| `dim_products.csv`     | Product details (name, category, product code) |
| `dim_stores.csv`       | Store location details (store ID, city) |

---

##  Tools Used

- **Microsoft Excel **
  - Power Pivot, DAX Measures, Pivot Charts,Power Query
  - Slicers, KPIs, and Shapes for interactive dashboards

- **MySQL Workbench**
  - SQL queries for data exploration and report generation

---

##  Excel Dashboards

 Interactive Dashboards:
1. **Store Performance Dashboard**
2. **Promotion Type Dashboard**
3. **Category- Product Analysis Dashboard**

Features:
- KPIs (Revenue, Units, IR%, ISU%)
- Pivot Charts & Slicers (Campaign, Promo Type, City)
- Navigation Buttons across sheets

---

## SQL-Based Business Requests

| Query No. | Business Request |
|-----------|------------------|
| 1 | List high-value BOGOF products (Base Price > ₹500) |
| 2 | City-wise store count |
| 3 | Campaign-wise total revenue (before vs. after promotions) |
| 4 | ISU% and ranking by category (Diwali campaign only) |
| 5 | Top 5 products by IR% across all campaigns |

---

## Key Insights

- **Cashback** promotions yielded the highest revenue gains.
- **BOGOF** led in volume increase, especially in Grocery & Staples.
- **Sankranti** campaign outperformed Diwali in total revenue.
- **Trivandrum** was one of the lowest-performing cities.
- Certain product categories (Home Care, Appliances) saw better returns under cashback promos.

---

## Recommendations

- Increase use of **cashback** in high-margin categories.
- Rethink **flat discount strategies** with low IR% or ISU%.
- Promote top-performing products identified by IR%.
- Improve store performance in weaker regions like **Trivandrum**.
- Consider product-category-promo alignment for best ROI.

---


