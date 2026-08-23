# Q1 2024 Sales Performance Report
## In-Store & Fuel Revenue Analysis

**Organisation:** QuickStop Markets  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Sales Performance  
**Prepared By:** Business Intelligence & Analytics Team  
**Date of Issue:** April 2024

---

## Executive Summary

QuickStop Markets closed the first quarter of 2024 with consistent revenue growth across both in-store merchandise and fuel operations, driven by stronger basket sizes in March and steady loyalty programme engagement. Across five active store locations spanning the Puget Sound and Willamette Valley regions, in-store transaction volumes and average transaction values both trended upward through the quarter, with March recording the highest weekly fuel gallons sold at fuel-enabled locations.

Tobacco and Vape remained the highest revenue-generating product category in absolute terms, led by cigarette and disposable vape pen sales, though the Fresh Deli category demonstrated strong margin expansion relative to its category share. Beverages continued to anchor basket-level attachment across all stores, appearing in a large proportion of multi-item transactions.

Store 1 (Bellevue Central) and Store 4 (Portland East) emerged as the top-performing locations overall when combining in-store and fuel revenue. Loyalty-enrolled customers accounted for a majority of identified card transactions and demonstrated materially higher average transaction values than anonymous shoppers.

As QuickStop heads into Q2, opportunities exist to deepen fresh category attachment, optimise fuel margin in a rising cost environment, and address inventory pressure emerging at several locations.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total In-Store Revenue (Q1) | $435.51 | Across 30 sampled transactions, five store locations |
| Total Fuel Revenue (Q1) | ~$12,505 | Stores 1, 3, and 4; Store 1 ~44% of total fuel revenue |
| Average In-Store Transaction Value | $14.52 | March average higher than January; improving basket sizes |
| Top Revenue Category | Tobacco & Vape | High unit prices; frequent co-purchase with Beverages |
| Loyalty Customer Share of Transactions | ~73% | Enrolled customers drive higher average spend |
| Top Performing Store | Store 1 — Bellevue Central | Leads in-store frequency and fuel revenue |
| Fuel Gallons Sold — Regular Grade | ~2,433 gallons | Stores 1, 3, 4 combined; consistent weekly growth |
| Gross Margin — Fresh Deli | ~60–64% | Highest margin category; Turkey Sandwich and Burrito lead |
| Card vs. Cash Split | ~77% Card / 23% Cash | Cash concentrated at Stores 3 and 5 |
| Monthly Revenue Trend | Increasing (Jan → Mar) | Consistent quarter-on-quarter growth trajectory |

---

## Section 1: Overall Revenue Performance by Month

Reviewing in-store transactions by month reveals a clear upward trajectory across Q1 2024. January established the baseline with 10 recorded transactions across all five stores, yielding moderate average basket sizes. February showed increased engagement from loyalty customers and higher-value category purchases. March demonstrated the strongest performance, with single-transaction totals reaching as high as $34.94.

This month-over-month growth pattern is consistent with seasonal foot traffic improvement as weather conditions improve across the Pacific Northwest in late Q1.

**Data fields used:** transactions.transaction_date, transactions.total_amount, transactions.store_id, transactions.payment_method

---

## Section 2: Revenue Breakdown by Product Category

Tobacco & Vape generated the largest revenue contribution, driven by high unit prices for cigarette packs ($9.99) and disposable vape pens ($12.99). These items frequently appeared alongside Beverages, suggesting a habitual co-purchase pattern.

Fresh Deli ranked second in revenue and delivered the highest gross margins — the Turkey Deli Sandwich and Breakfast Burrito both carry margins above 60%. Beverages performed as a consistent basket-builder category. Snacks & Candy and Household Essentials served as supplementary attachment items.

**Data fields used:** transaction_items.product_id, transaction_items.line_total, transaction_items.unit_price, transaction_items.unit_cost, products.product_name, product_categories.category_name

---

## Section 3: Store-Level Performance Comparison

Store 1 (Bellevue Central) led all locations in both transaction volume and total revenue during Q1. Store 4 (Portland East) ranked closely behind when fuel revenue is included. Store 2 (Seattle Pike) maintained solid in-store performance despite lacking fuel services. Store 3 (Tacoma South) demonstrated healthy Fresh Deli and Beverage sales. Store 5 (Eugene Main) showed lower overall volume consistent with its recent opening date.

Stores without fuel are structurally limited in total revenue potential and may benefit from accelerated fresh and specialty category expansion.

**Data fields used:** stores.store_id, stores.store_name, stores.city, stores.region, stores.has_fuel, transactions.store_id, transactions.total_amount

---

## Section 4: Fuel Sales Analysis — Volume, Mix, and Margin

Fuel operations at Stores 1, 3, and 4 generated substantial revenue across Q1. Store 1 (Bellevue Central) recorded the highest total fuel revenue, driven by high Regular-grade volume and a meaningful Premium grade mix. Regular gasoline accounted for the largest share of gallons sold. Diesel sales occurred consistently, indicating a reliable commercial vehicle segment.

Price-per-gallon for all fuel types trended upward across the quarter — Regular rising from approximately $3.44 to $3.60 — reflecting regional wholesale price movements. Margin per gallon remained relatively stable. Premium grade carried the highest retail price and per-gallon margin, representing a revenue quality opportunity if mix can be shifted through forecourt incentives.

**Data fields used:** fuel_sales.store_id, fuel_sales.sale_date, fuel_sales.fuel_type, fuel_sales.gallons_sold, fuel_sales.price_per_gallon, fuel_sales.cost_per_gallon, fuel_sales.total_revenue

---

## Section 5: Loyalty Programme Contribution

Of the 30 Q1 transactions, approximately 22 were linked to identified customers, the majority of whom were active loyalty members. High-point-balance customers including Derek Okafor (8,750 pts), James Whitfield (6,300 pts), and Aisha Grant (5,500 pts) consistently appeared in higher-value transactions.

Non-enrolled customers were concentrated in lower-value cash transactions. Two current customers — Priya Nair and Tyler Brooks — are not enrolled, representing conversion opportunities. Upcoming redemption events from high-balance members should be anticipated in Q2 revenue forecasting.

**Data fields used:** customers.loyalty_enrolled, customers.loyalty_points, customers.joined_date, transactions.customer_id, transactions.total_amount

---

## Section 6: Payment Method and Transaction Behaviour

Card payments accounted for approximately 77% of all Q1 in-store transactions. Cash was more prevalent at Stores 3 and 5. Card-paying customers tended to have higher transaction totals on average, aligning with the loyalty programme's card-first structure. Anonymous cash transactions typically comprised one to three low-cost items.

This pattern supports a potential initiative to incentivise card payment adoption at cash-heavy locations, which could simultaneously drive loyalty sign-ups and basket value improvements.

**Data fields used:** transactions.payment_method, transactions.total_amount, transactions.customer_id, transactions.store_id

---

## Appendix & Notes

### Assumptions
- Transaction records represent a representative sample; full-quarter totals in production would be materially larger.
- Fuel sales records are aggregated weekly per store.
- Loyalty point balances are cumulative as of the data extraction date.
- Margin calculations assume no promotional discounting was applied.
- Stores 2 and 5 have no fuel sales records, consistent with the has_fuel flag.

### Known Limitations
- 30 in-store transactions is a representative sample; live data would contain significantly more records.
- No returns, refunds, or voided transactions are captured; gross revenue may be marginally overstated.
- Fuel margin analysis excludes delivery fees and environmental compliance costs.
- Customer demographic segmentation is limited to enrolment status and loyalty points.

### Recommended Next Analysis
- Daypart transaction analysis to identify peak traffic windows per store.
- Loyalty redemption forecasting based on current point balances.
- Category cross-purchase affinity analysis for shelf placement optimisation.
- Fuel margin sensitivity modelling for continued wholesale price increases.
- Non-enrolled customer conversion targeting at cash-heavy locations.
- Store 5 (Eugene Main) growth trajectory assessment.

---
*Report generated by QuickStop Markets Business Intelligence & Analytics Team. For internal use only.*
