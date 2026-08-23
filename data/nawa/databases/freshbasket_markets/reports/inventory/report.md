# Q1 2024 Inventory Health & Stock Management Report

**Organisation:** FreshBasket Markets  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Prepared by:** Business Intelligence & Reporting Team  
**Classification:** Internal Management Report

---

## Executive Summary

This report provides an assessment of inventory health across FreshBasket Markets' five store locations as at the end of Q1 2024. The analysis draws on end-of-quarter stock snapshot data, product-level cost and pricing information, and transaction-level unit sales to evaluate stock adequacy, identify at-risk product lines, and support procurement planning for Q2 2024.

Overall, the majority of monitored stock-keeping units across stores maintained healthy quantities above their designated reorder thresholds at the close of the quarter. However, a number of items — most notably Dishwasher Tablets (30pk) across Beaverton and Bellevue — were identified as having fallen below their reorder levels, raising a moderate replenishment risk if sales velocity maintained its March trajectory.

Meat & Seafood products exhibited some of the tightest stock margins relative to reorder levels, particularly Atlantic Salmon Fillet at Portland Central and Seattle North. Given that this category is the highest revenue contributor and operates on a perishable handling cycle, maintaining adequate stock buffers is operationally critical.

Looking ahead to Q2, procurement planning should account for anticipated demand uplift driven by seasonal fresh produce availability, the continuation of promotional activity, and the expected growth in click-and-collect fulfilment at suburban locations.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total SKUs Monitored | 23 | Across 5 stores and 16 products, end of Q1 2024 |
| SKUs Below Reorder Level | 2 | Dishwasher Tablets at Beaverton and Bellevue |
| SKUs Within 20% of Reorder | 3 | Atlantic Salmon, Chicken Breast, Frozen Pizza at Bellevue |
| Most Restocked Product Type | Fresh Produce & Dairy | Consistent with perishable restocking cycles |
| Highest Absolute Stock (Single SKU) | FreshBasket Pasta — 300 units (Portland Central) | Dry goods maintain high buffer levels |
| Lowest Absolute Stock (Below Reorder) | Dishwasher Tablets — 12 units (Bellevue) | 40% below reorder level of 20 |
| Private-Label Stock Representation | 7 of 16 products | Well-represented own-brand SKUs across stores |
| Avg. Days Since Last Restock (Perishables) | ~4–6 days | Restocked within final week of March |

---

## Report Sections

### 1. Stock Level Status by Store and Product

A review of end-of-quarter stock quantities against reorder thresholds across all 23 monitored inventory records reveals that the majority of SKUs are adequately stocked. Portland Central holds the largest absolute inventory volumes, particularly for dry goods. Beaverton and Bellevue present the most critical stock positions, with Dishwasher Tablets at both locations falling at or below reorder levels. Seattle North and Eugene show balanced inventory profiles with no immediate replenishment alerts. Suburban stores may benefit from more frequent automated reorder triggers.


**Data Fields:** inventory.store_id, inventory.product_id, inventory.stock_quantity, inventory.reorder_level, stores.store_name, products.product_name

---

### 2. At-Risk SKUs Requiring Immediate Replenishment

Two SKUs have been identified as below their designated reorder thresholds: Dishwasher Tablets at Beaverton (stock 18, reorder 20) and Bellevue (stock 12, reorder 20). Three additional SKUs — Atlantic Salmon at Portland Central, Chicken Breast at Bellevue, and Frozen Margherita Pizza at Bellevue — are within 20% of their reorder thresholds. Given the perishable nature of some of these items and their role in high-value customer baskets, procurement should initiate supplier contact for expedited replenishment.


**Data Fields:** inventory.stock_quantity, inventory.reorder_level, inventory.store_id, inventory.product_id, products.product_name, categories.category_name, stores.store_name

---

### 3. Inventory Value and Margin Exposure

Combining inventory quantities with unit cost data provides an estimate of the current stock value held across each store. Atlantic Salmon Fillet represents the highest unit cost item in stock, meaning spoilage or write-off in this category carries significant financial exposure. Packaged Goods such as FreshBasket Pasta carry low unit costs and high volumes, representing lower per-unit financial risk. Private-label items offer the strongest cost-to-price margin and should be maintained at adequate levels to protect margin contribution. Perishable goods rotation should be closely monitored to minimise wastage.


**Data Fields:** inventory.stock_quantity, inventory.product_id, inventory.store_id, products.unit_cost, products.unit_price, products.is_private_label, categories.category_name

---

### 4. Restocking Recency and Supply Chain Cadence

Perishable categories were restocked most recently, with the majority of relevant SKUs restocked within the final five days of March. Non-perishable categories show slightly older restock dates, which is operationally appropriate. One notable exception is Dishwasher Tablets at Bellevue, last restocked March 18 — over ten days before the snapshot date — suggesting a potential supplier delivery delay or replenishment oversight that contributed to its below-threshold stock position.


**Data Fields:** inventory.last_restocked_date, inventory.product_id, inventory.store_id, inventory.stock_quantity, products.product_name, categories.category_name

---

### 5. Inventory vs. Sales Velocity by Category

Cross-referencing inventory stock levels with Q1 transaction item volumes indicates that Meat & Seafood products featured in numerous high-quantity transactions, suggesting strong sell-through rates that tightened end-of-quarter positions. Fresh Produce also showed high unit volumes. Packaged Goods and Frozen Foods demonstrated moderate velocity, supported by January and February promotional activity. Household & Cleaning products picked up in March under the Spring Clean promotion, reflected in reduced Portland Central stock levels at quarter end.


**Data Fields:** transaction_items.product_id, transaction_items.quantity, inventory.stock_quantity, products.category_id, categories.category_name, transactions.transaction_date

---

### 6. Q2 2024 Replenishment Planning Recommendations

Based on Q1 stock snapshot and sales velocity data, the following priorities are recommended for Q2: Dishwasher Tablets require immediate restocking at Beaverton and Bellevue. Atlantic Salmon and Chicken Breast stock buffers should be increased at high-traffic stores ahead of warmer-month demand. Packaged and Frozen stock levels appear sufficient but should be reviewed following any new promotions. Click-and-Collect pick stock at Beaverton should be held at a higher buffer. A formal reorder automation review is recommended for all suburban stores.


**Data Fields:** inventory.stock_quantity, inventory.reorder_level, inventory.store_id, inventory.product_id, products.product_name, transactions.channel, stores.store_type

---

## Appendix & Notes

### Assumptions
- Inventory data is a point-in-time snapshot at end of Q1 2024 and does not reflect intra-quarter movements.
- Estimated stock value uses inventory.stock_quantity multiplied by products.unit_cost and excludes shrinkage or pending deliveries.
- Reorder level thresholds are as recorded in the inventory table and assumed to reflect current operational policy.
- Sales velocity assessments are based on total Q1 transaction_items unit volumes.
- Standard 3–5 business day supplier lead time is assumed for replenishment urgency assessments.

### Known Limitations
- Only 23 product-store inventory records are available; the full store range is broader.
- No intra-quarter stock movements are recorded; temporary stockouts cannot be identified.
- Spoilage, waste, and shrinkage are not captured; perishable stock values may be overstated.
- Supplier and purchase order data are not in the current schema.
- No receiving records exist to calculate restocking volumes per delivery.

### Recommended Next Analysis
- Implement a stock movement log to capture daily stock-in and stock-out events, enabling velocity and turn rate calculations.
- Add supplier and purchase order tables to support full procurement lifecycle analysis.
- Develop a demand forecasting model using Q1 sales velocity adjusted for seasonal patterns.
- Conduct a spoilage and shrinkage audit for perishable categories.
- Review and update reorder level thresholds for suburban stores to reflect click-and-collect demand growth.

---

*Report generated by FreshBasket Markets BI Team | Q1 2024 | Confidential — Internal Use Only*
