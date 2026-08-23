# Q1 2024 Inventory & Procurement Status Report

**Organisation:** Harvest Ridge Supply Co.
**Reporting Period:** January 1, 2024 – March 31, 2024
**Report Type:** Inventory & Procurement
**Prepared By:** Operations & Supply Chain Team
**Date Issued:** April 5, 2024

---

## Executive Summary

This report provides a comprehensive review of inventory positions and procurement activity at Harvest Ridge Supply Co. for the first quarter of 2024. The quarter was characterized by heavy inbound procurement to build stock ahead of the spring planting season, with purchase orders issued to all seven active suppliers across January, February, and March. A total of 22 purchase orders were placed during the period, with 21 received and one remaining in pending status as of quarter close.

Inventory management during Q1 reflected the seasonal demand profile of the business. High-velocity crop input items — particularly Corn Seed Hybrid H200, Urea Fertilizer, and Glyphosate Herbicide — were restocked multiple times across the quarter. Despite this, the Hydraulic Filter Kit ended Q1 below its defined reorder threshold, representing the most acute stock risk heading into Q2. Insecticide MaxGuard also approached its reorder level by quarter end.

Supplier reliability was strong across the quarter, with all received purchase orders fulfilled without recorded discrepancies. Pioneer AgriSeed Corp. was the most active supplier by order frequency and total procurement value. Great Plains Feed Co. provided consistent and timely deliveries of livestock feed throughout the quarter.

Heading into Q2, inventory strategy should focus on expediting the outstanding pending order for Insecticide MaxGuard, proactively assessing safety stock for Corn Seed Hybrid H200, and conducting a formal reorder point review for the Farm Equipment Accessories category.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Purchase Orders Placed (Q1 2024) | 22 | Issued to all seven active suppliers across the quarter. |
| Purchase Orders Received | 21 of 22 | One order (Insecticide MaxGuard, PO #22) remains pending. |
| Total Procurement Spend (Q1 2024) | Approx. $111,800 | Quantity ordered × unit cost across all Q1 purchase orders. |
| SKUs Below Reorder Level at Quarter End | 2 | Hydraulic Filter Kit (8 units) and Insecticide MaxGuard (18 units). |
| Total Active SKUs Tracked | 18 | All 18 product SKUs have current inventory records. |
| Most Restocked Product | Corn Seed Hybrid H200 | Received two separate purchase order deliveries in Q1. |
| Top Supplier by Procurement Value | Pioneer AgriSeed Corp. | Supplied across four purchase orders for seed categories. |
| Pending Purchase Orders at Quarter End | 1 | PO #22 for Insecticide MaxGuard, placed March 16, 2024. |

---

## Report Sections

### 1. Current Inventory Positions and Reorder Risk

As of March 31, 2024, all 18 active SKUs maintain recorded inventory positions. The majority of products are within acceptable stock ranges relative to their defined reorder thresholds. However, two SKUs present elevated risk: the Hydraulic Filter Kit currently holds 8 units against a reorder level of 10, and Insecticide MaxGuard holds 18 units against a reorder level of 20. A pending purchase order for MaxGuard is expected to resolve this, but delivery timing risk remains. All other products are adequately stocked, with Livestock Feed items holding the deepest safety stock positions.

**Data fields:** inventory.product_id, inventory.quantity_on_hand, inventory.last_restocked_date, products.reorder_level, products.product_name, categories.category_name

---

### 2. Procurement Activity by Supplier

All seven active suppliers received purchase orders during Q1 2024. Pioneer AgriSeed Corp. was the most active, with four purchase orders across seed categories. NutriGrow Fertilizers LLC fulfilled three fertilizer orders. Great Plains Feed Co. processed two livestock feed orders. ShieldChem Agricultural fulfilled two crop protection orders, with a third pending. IronHand Equipment Parts and AquaFlow Irrigation Systems each received two orders. No supplier reliability issues were recorded, and all received orders were logged as fulfilled.

**Data fields:** purchase_orders.supplier_id, suppliers.supplier_name, purchase_orders.order_date, purchase_orders.status, purchase_orders.quantity_ordered, purchase_orders.unit_cost

---

### 3. Procurement Spend by Month

Procurement spending was weighted toward January and March, aligned with the business's practice of building stock ahead of demand surges. January saw the largest initial round of purchase orders establishing baseline inventory. February focused on supplementary replenishment of fertilizers, crop protection, and equipment parts. March was the most intensive by order count, with significant restocking of seed and fertilizer products. This rolling replenishment approach reflects sound inventory management practice.

**Data fields:** purchase_orders.order_date, purchase_orders.quantity_ordered, purchase_orders.unit_cost, purchase_orders.supplier_id, purchase_orders.status

---

### 4. Stock Consumed vs. Stock Received by Category

Comparing units sold through order_items against units received through purchase_orders reveals that Seeds & Seed Treatments experienced the tightest stock utilization, with Corn Seed Hybrid H200 closely tracking procurement receipts. Fertilizers maintained comfortable buffer stock throughout the quarter. Crop Protection products turned over rapidly, with Glyphosate Herbicide moving most quickly. Livestock Feed maintained deep stock levels appropriate for its steady year-round demand profile. Equipment Accessories had the lowest inbound volume and the tightest stock situation at quarter end.

**Data fields:** order_items.product_id, order_items.quantity, purchase_orders.product_id, purchase_orders.quantity_ordered, products.category_id, categories.category_name

---

### 5. Supplier Dependency and Concentration Risk

Pioneer AgriSeed Corp. represents the highest single-supplier dependency, supplying all three seed SKUs — products accounting for a significant portion of Q1 revenue. Any supply chain disruption during March-to-May would carry material revenue risk. NutriGrow Fertilizers LLC is the sole supplier for all three fertilizer SKUs, representing a similar risk in the second-highest revenue category. Management is advised to assess dual-sourcing arrangements for these two categories and maintain closer communication with both suppliers regarding forward availability.

**Data fields:** suppliers.supplier_id, suppliers.supplier_name, products.product_id, products.supplier_id, categories.category_name, purchase_orders.quantity_ordered

---

### 6. Pending Orders and Outstanding Procurement Risk

As of the close of Q1 2024, one purchase order remains pending: PO #22 for Insecticide MaxGuard (80 units) from ShieldChem Agricultural, placed March 16, 2024. With current inventory at 18 units and a reorder threshold of 20, any further sales before delivery will push stock below the safety level. The operations team should confirm the expected delivery date with ShieldChem Agricultural and expedite if necessary. No other purchase orders were unresolved at quarter end.

**Data fields:** purchase_orders.po_id, purchase_orders.status, purchase_orders.order_date, purchase_orders.quantity_ordered, purchase_orders.product_id, inventory.quantity_on_hand, products.reorder_level

---

## Appendix

### Assumptions
- Quantity on hand reflects end-of-quarter positions after all Q1 sales and received purchase orders have been applied.
- Procurement spend is calculated as quantity_ordered × unit_cost per purchase order row.
- PO #22 (pending) is excluded from inventory on-hand figures.
- All received purchase orders are assumed fully delivered at the specified unit cost.
- Reorder levels represent the minimum quantity on hand before replenishment should be initiated.

### Known Limitations
- The schema does not track shrinkage, damage, or write-offs; actual on-hand quantities may differ.
- No supplier lead time data is captured, limiting forward reorder point calculations.
- The inventory table stores a single current snapshot; historical daily stock levels cannot be reconstructed.
- No warehouse location or bin-level tracking is included.

### Recommended Next Analysis
- Add a supplier lead time field to enable forward-looking reorder point calculations.
- Conduct an ABC analysis of SKUs by revenue contribution and stock turn rate.
- Develop a Q2 procurement plan aligned with Q1 sales velocity, with emphasis on seed and fertilizer.
- Explore dual-sourcing for Pioneer AgriSeed Corp. and NutriGrow Fertilizers LLC.
- Add an inventory transaction log table to capture daily movements and enable trend analysis.

---
*Report generated by Harvest Ridge Supply Co. Operations & Supply Chain Team. For internal use only.*
