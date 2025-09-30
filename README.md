# Sales Trend Analysis (Task 6)

## Objective
Analyze monthly revenue and order volume using SQL aggregations.

## Methodology
- Grouped data by year and month using SQL’s EXTRACT function.
- Calculated monthly revenue with SUM(amount).
- Determined order volume with COUNT(DISTINCT order_id).
- Ordered results chronologically.
- Identified top 3 months by revenue.
- Ensured NULL values in amount were handled using COALESCE.

## Steps Done
1. Extract month and year from `order_date`.
2. Calculate:
   - `SUM(amount)` as **monthly revenue**
   - `COUNT(DISTINCT order_id)` as **order volume**
3. Group results by month/year.
4. Order results chronologically.
5. Identify top 3 months by revenue.
6. Handle NULL values with `COALESCE`.

## Output
- Monthly revenue & order volume table
- Top 3 months by revenue

##  Generated Single CSV with All Queries

Instead of running the three queries separately, we can use the **combined SQL query** `combined_task6.sql`:

* The query uses **CTEs (WITH statements)** to create:

  1. `monthly` → Monthly Revenue and Order Volume
  2. `top3` → Top 3 Months by Revenue
  3. `nullsafe` → Revenue Handling NULLs

* It then **UNION ALLs** these sections into a single result with a `Section` column to label each output.

* After Running the query, The output will look like:

| Section                          | Year | Month | Monthly_Revenue | Order_Volume |
| -------------------------------- | ---- | ----- | --------------- | ------------ |
| Monthly Revenue and Order Volume | 2023 | 01    | 1,270           | 4            |
| Top 3 Months by Revenue          | 2023 | 03    | 3,490           | 6            |
| Revenue Handling NULLs           | 2023 | 02    | 2,800           | 5            |

* This produces a **single CSV file** containing all three analyses.

Conclusion
The SQL aggregation techniques reveal sales seasonality and highlight peak business periods,
which can help with resource planning, marketing, and inventory decisions.
