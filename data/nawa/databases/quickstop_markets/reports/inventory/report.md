# Q1 2024 Inventory Status & Replenishment Risk Report

**Organisation:** QuickStop Markets  
**Reporting Period:** As of March 31, 2024  
**Report Type:** Inventory  
**Prepared By:** Business Intelligence & Analytics Team  
**Date of Issue:** April 2024

---

## Executive Summary

This report presents the end-of-quarter inventory position across five QuickStop Markets locations as of March 31, 2024, identifying stock levels relative to established reorder thresholds and flagging products at immediate or near-term replenishment risk. The inventory snapshot captures 22 product-store combinations representing key SKUs across the Beverages, Fresh Deli, Tobacco & Vape, Household Essentials, and Frozen & Dairy categories.

The most pressing replenishment concern is at Store 4 (Portland East), where Laundry Detergent Pod 10ct has a quantity-on-hand of just five units against a reorder level of ten — placed below threshold and requiring an immediate purchase order. Additionally, Store 2's Chips Regular Bag inventory of 12 units against a reorder level of 25 presents a significant stockout risk given the product's high attachment rate in multi-item transactions.

Conversely, several locations maintain healthy or surplus inventory positions. Store 1's Bottled Water and Fountain Drink stocks are well above reorder thresholds, and Store 3's Cigarette stock at 62 units provides comfortable cover. These positions reduce short-term procurement urgency and may allow for restocking cycle extension.

The report recommends immediate action on three at-risk SKUs, a review of reorder level parameters for high-velocity items, and consideration of a streamlined replenishment protocol for Stores 4 and 2.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| SKU-Store Combinations Monitored | 22 | Across 5 stores and 14 distinct products |
| SKUs Below or At Reorder Level | 3 | Store 4 Detergent (below), Store 2 Chips (below), Store 4 Vape Pen (at threshold) |
| Highest Stock Position | 90 units | Store 2 — Bottled Water 1L; well above reorder level of 30 |
| Most Recently Restocked | March 28, 2024 | Store 1 Deli Sandwich and Store 2 Fresh Deli items |
| Highest Replenishment Risk Store | Store 4 — Portland East | Two SKUs at or below threshold |
| Oldest Last-Restock Date | March 10, 2024 | Store 4 Laundry Detergent; 21 days since restock |
| Fresh Deli Coverage | 8–18 units per store | Adequate but requires close freshness monitoring |
| Tobacco & Vape Position | Adequate at most stores | Vape Pen at Store 4 exactly at reorder threshold |

---

## Section 1: Inventory Snapshot — Stock Levels vs. Reorder Thresholds

As of March 31, 2024, three inventory records are at or below their configured reorder levels: Store 4's Laundry Detergent Pod 10ct (5 units; reorder level 10), Store 2's Chips Regular Bag (12 units; reorder level 25), and Store 4's Disposable Vape Pen (10 units; exactly at reorder level). All other monitored SKUs maintain quantities above their thresholds. The overall position is manageable, but the concentration of below-threshold records at Store 4 warrants prompt procurement action.

**Data fields used:** inventory.store_id, inventory.product_id, inventory.quantity_on_hand, inventory.reorder_level, inventory.last_restocked_date, products.product_name, product_categories.category_name

---

## Section 2: Critical Replenishment Alerts

Three SKUs require immediate or near-term replenishment action:

- **Laundry Detergent Pod 10ct — Store 4 (Portland East):** 5 units vs. reorder level 10. Last restocked March 10 (21 days ago). Purchase order required immediately.
- **Chips Regular Bag — Store 2 (Seattle Pike):** 12 units vs. reorder level 25 (52% shortfall). High transaction attachment rate increases stockout risk within days.
- **Disposable Vape Pen — Store 4:** Exactly at reorder threshold of 10 units. Any further sales will breach threshold; top-up order recommended.

**Data fields used:** inventory.product_id, inventory.store_id, inventory.quantity_on_hand, inventory.reorder_level, inventory.last_restocked_date, products.product_name, products.unit_price, products.unit_cost

---

## Section 3: Well-Stocked Positions and Restocking Cycle Optimisation

Several product-store combinations hold stock well above reorder thresholds, presenting an opportunity to rationalise delivery frequency:

- Store 2 — Bottled Water 1L: 90 units vs. reorder level 30 (3x threshold)
- Store 1 — Large Fountain Drink: 85 units vs. reorder level 20
- Store 3 — Cigarettes Pack King: 62 units vs. reorder level 30

Central procurement should review whether reorder levels for these SKUs reflect current sales velocity and whether delivery frequency can safely be reduced.

**Data fields used:** inventory.product_id, inventory.store_id, inventory.quantity_on_hand, inventory.reorder_level, inventory.last_restocked_date, products.product_name, product_categories.category_name

---

## Section 4: Fresh Deli Inventory Management

Fresh Deli items require vigilant monitoring given their perishable nature. Store 1's Deli Sandwich Turkey shows 18 units restocked on March 28 — appropriate for end-of-quarter fresh stock management. Store 2's Deli Sandwich Turkey at 8 units (reorder level 10) suggests rapid sell-through requiring early April delivery. Store 3's Breakfast Burrito at 30 units (reorder level 20) is comfortable but aging from the March 25 restock.

A recommendation is made to add a best-before or expiry date field to the inventory schema to support freshness compliance reporting in future periods.

**Data fields used:** inventory.product_id, inventory.store_id, inventory.quantity_on_hand, inventory.reorder_level, inventory.last_restocked_date, products.product_name, product_categories.category_name, product_categories.department

---

## Section 5: Store-Level Inventory Risk Ranking

Ranking by number of SKUs at or below reorder threshold:

1. **Store 4 — Portland East (HIGHEST RISK):** 2 SKUs flagged (Laundry Detergent below; Vape Pen at threshold)
2. **Store 2 — Seattle Pike:** 1 SKU flagged (Chips Regular Bag below threshold)
3. **Stores 1, 3, 5:** No SKUs below threshold; monitoring recommended for select items

Store 4's repeat appearance in alerts may reflect a structural supply chain or logistics gap in the Willamette Valley region requiring operational review.

**Data fields used:** inventory.store_id, inventory.product_id, inventory.quantity_on_hand, inventory.reorder_level, stores.store_name, stores.city, stores.region

---

## Section 6: Reorder Level Calibration Review

Several reorder levels appear potentially miscalibrated relative to observed Q1 sales velocity. Chips Regular Bag at Store 2 has a reorder level of 25, but frequent appearance in transaction records suggests a threshold of 35–40 units would be more appropriate. Conversely, Large Fountain Drink at Store 1 holds 85 units against a reorder level of just 20, suggesting the threshold was set under lower-traffic conditions.

A formal reorder level audit cross-referencing inventory positions with sales velocity from transaction_items data is recommended as a Q2 planning exercise.

**Data fields used:** inventory.product_id, inventory.store_id, inventory.quantity_on_hand, inventory.reorder_level, transaction_items.product_id, transaction_items.quantity, products.product_name

---

## Appendix & Notes

### Assumptions
- Inventory records represent end-of-quarter stock positions as of March 31, 2024.
- Reorder levels reflect thresholds set by the central procurement team.
- Last_restocked_date represents the most recent full replenishment event.
- No spoilage or shrinkage adjustments are reflected in quantity_on_hand figures.
- The inventory table covers a representative SKU subset, not the full product catalogue.

### Known Limitations
- No best-before or expiry date field exists in the schema, limiting freshness analysis for perishables.
- No supplier lead time data is available to calculate days-of-stock-remaining vs. next delivery.
- Inventory coverage is incomplete across all store-product combinations.
- Sales velocity estimates are based on a transaction sample; full-quarter data would improve accuracy.
- Shrinkage and waste are not tracked and may cause discrepancies between system and physical stock.

### Recommended Next Analysis
- Integrate transaction_items data with inventory to calculate estimated days of stock remaining per SKU.
- Add supplier lead time data to enable delivery-window-adjusted reorder points.
- Introduce product expiry tracking for Fresh Deli and Frozen & Dairy categories.
- Conduct a full reorder level audit calibrated against Q1 sales velocity.
- Investigate Store 4 (Portland East) supply chain performance.
- Develop a weekly automated inventory alert report flagging below-threshold positions.

---
*Report generated by QuickStop Markets Business Intelligence & Analytics Team. For internal use only.*
