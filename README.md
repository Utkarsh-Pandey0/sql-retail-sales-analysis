# sql-retail-sales-analysis
An end-to-end relational database analysis mapping retail sales performance. This project utilizes advanced SQL (CTEs, Window Functions, Subqueries) to calculate Customer Lifetime Value (CLV), Month-over-Month revenue growth, and product category performance.
# Retail Sales Analytics: Customer Lifetime Value & Revenue Velocity

## The Business Problem
Retail operations generate massive amounts of transactional data across disparate tables (customers, products, and orders). Without a unified analytical model, businesses struggle to identify their most valuable customers, track true revenue growth month-over-month, and isolate underperforming inventory. This project bridges that gap by transforming raw, normalized relational database tables into actionable business intelligence.

## The Methodology
This project utilizes a custom-built relational database (`retail_sales_db`) with a normalized schema. Advanced SQL techniques were deployed to extract strategic metrics rather than simple data dumps. 

**Key Analytical Techniques Applied:**
*   **Customer Lifetime Value (CLV) & VIP Segmentation:** Utilized nested subqueries and `HAVING` clauses to isolate customers whose total spend exceeds the store-wide average, and applied `DENSE_RANK()` window functions to tier VIP buyers.
*   **Revenue Velocity & MoM Growth:** Engineered Common Table Expressions (CTEs) combined with `LAG()` window functions to calculate Month-over-Month (MoM) revenue growth percentages and running totals, providing a clear view of financial momentum.
*   **Inventory Optimization:** Deployed `LEFT JOIN` logic to identify "dead stock" (products with zero orders) and aggregated sales by category to inform future purchasing decisions.
*   **Demographic & Geographic Profiling:** Grouped average order values (AOV) by gender and mapped total revenue by city/state to identify highly profitable regional markets.

## The Strategic Outcome
The SQL pipeline successfully condenses complex transactional histories into core operational metrics. By establishing automated queries for CLV, MoM growth, and inventory movement, marketing teams are equipped to target high-value cohorts, while supply chain teams can confidently phase out dead stock.

## Technical Stack
*   **Database:** MySQL / SQL Server
*   **Data Modeling:** Relational Schema Design (Primary/Foreign Key Constraints)
*   **Advanced SQL:** Common Table Expressions (CTEs), Window Functions (`RANK`, `DENSE_RANK`, `LAG`, `SUM OVER`), Aggregate Functions, Date/Time Parsing, Multi-table `JOIN`s.
*   **Analytical Domain:** Retail Operations, Financial Reporting, Customer Segmentation

## Author
**Utkarsh Pandey**  
Translating raw relational data into optimized business strategies and financial insights.

