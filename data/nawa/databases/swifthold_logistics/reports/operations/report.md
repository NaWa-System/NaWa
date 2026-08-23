# Q1 2024 Fulfillment Operations Performance Report

**Organisation:** SwiftHold Logistics  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Operations  
**Prepared By:** SwiftHold Analytics & Operations Team  
**Date Issued:** April 2024

---

## Executive Summary

SwiftHold Logistics experienced a period of sustained operational activity across both distribution centers during Q1 2024, processing outbound shipments for five active clients and managing inbound receipts totaling over 19,000 units across the quarter. The Columbus DC (OH) handled the majority of outbound volume, driven primarily by high-frequency clients in the apparel and beauty segments, while the Reno DC (NV) supported clients in the nutrition and outdoor equipment verticals.

Outbound order volumes showed a consistent upward trend from January through March, with Brightline Beauty and PixelWear Apparel posting the most significant month-on-month growth in units shipped. Returns volumes increased modestly across the quarter, consistent with typical post-holiday return tail patterns in January and a slight uptick in March that warrants monitoring. The overall restock rate for returned units remained healthy, averaging above 80% across all clients.

Inventory levels declined steadily across most SKUs through the quarter, indicating strong sell-through rates. However, several clients—particularly Verde Nutrition and PixelWear Apparel—may need to accelerate inbound replenishment cycles in Q2 to avoid potential stockout risk.

Overall, Q1 2024 demonstrated SwiftHold's ability to scale outbound throughput without a proportional increase in operational exceptions. The operations team should focus Q2 planning on returns trend monitoring, proactive client inventory reviews, and carrier performance benchmarking.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Orders Shipped (Q1) | 7,768 orders | Aggregated across all active clients and both DCs, January–March 2024. |
| Total Units Shipped (Q1) | 14,415 units | Units shipped increased each month; March recorded the highest single-month volume. |
| Total Units Received (Q1) | 19,950 units | 15 receipt events across both DCs, averaging ~1,330 units per receipt. |
| Total Returns Processed (Q1) | 793 units | Returns increased slightly through the quarter; March saw the highest count. |
| Average Restock Rate | 81.8% | Units restocked as a percentage of total units returned across all clients. |
| Units Disposed (Q1) | ~144 units | ~18% of returned units; PixelWear Apparel drove the highest disposal rate. |
| Active Clients Served | 5 clients | All five active clients generated outbound activity in every month of Q1. |
| Columbus DC Outbound Share | ~63% of total orders | Concentration of high-frequency clients at Columbus drove majority throughput. |
| Fastest Growing Client (Volume) | Brightline Beauty | Units shipped grew from ~1,240 in January to 1,500 in March, a 21% increase. |

---

## Section 1: Outbound Shipment Volume by Client

Outbound shipment activity was distributed unevenly across the five active clients during Q1 2024. Brightline Beauty and PixelWear Apparel consistently ranked as the highest-volume clients by both orders and units shipped, together accounting for over half of total outbound throughput across the quarter. Verde Nutrition and Lumos Home Goods maintained stable mid-tier volumes, while TrekMate Outdoors generated the lowest order counts but with heavier average unit weights due to the nature of its product catalog.

Month-on-month growth was observed across most clients, with no clients recording a decline in outbound activity between February and March, suggesting healthy end-customer demand heading into Q2.

**Data Fields Used:** outbound_shipments.client_id, outbound_shipments.ship_date, outbound_shipments.orders_shipped, outbound_shipments.units_shipped, clients.client_name

---

## Section 2: Warehouse Throughput by Distribution Center

The Columbus DC handled a disproportionately large share of outbound shipment events relative to the Reno DC during Q1 2024. Columbus processed outbound batches for three clients—Lumos Home Goods, PixelWear Apparel, and Brightline Beauty—resulting in 14 distinct shipment events across the quarter. Reno DC served two clients—Verde Nutrition and TrekMate Outdoors—processing 8 shipment events with generally heavier per-unit weights and larger inbound pallet volumes.

Capacity utilization remained stable at both sites based on end-of-month inventory snapshot data, with no warehouse approaching its pallet capacity ceiling.

**Data Fields Used:** outbound_shipments.warehouse_id, outbound_shipments.orders_shipped, inbound_receipts.pallets_received, inventory_snapshots.pallets_occupied, warehouses.warehouse_name, warehouses.total_pallet_capacity

---

## Section 3: Inbound Receiving Activity

A total of 15 inbound receipt events were logged across both distribution centers during Q1 2024. Units received peaked in January before normalizing in February and stabilizing in March. Brightline Beauty was the largest contributor of inbound volume in both January and March, reflecting its aggressive replenishment cadence to support high outbound throughput. Verde Nutrition also generated significant pallet-heavy inbound receipts due to the bulk nature of protein supplement SKUs.

Receiving fees totaled a meaningful portion of Q1 billing for all clients, and the consistent inbound schedule suggests clients are managing replenishment proactively.

**Data Fields Used:** inbound_receipts.client_id, inbound_receipts.warehouse_id, inbound_receipts.received_date, inbound_receipts.units_received, inbound_receipts.pallets_received, inbound_receipts.receiving_fee, clients.client_name

---

## Section 4: Inventory Levels and End-of-Month Snapshots

End-of-month inventory snapshots captured a clear downward trend in units on hand across the majority of SKUs throughout Q1 2024. This trajectory is consistent with healthy sell-through and limited over-stocking, which is operationally favorable. However, several SKUs—notably Verde Nutrition's protein tub (VN-010) and PixelWear Apparel's hoodie SKU (PW-202)—experienced more pronounced inventory drawdowns relative to their inbound replenishment rates.

If these trends continue into Q2, clients may face stockout risk. Pallets occupied correspondingly declined across most SKUs, contributing to gradual freeing of storage space at both DCs.

**Data Fields Used:** inventory_snapshots.sku_id, inventory_snapshots.snapshot_date, inventory_snapshots.units_on_hand, inventory_snapshots.pallets_occupied, skus.sku_code, skus.description

---

## Section 5: Returns Processing and Restock Performance

Returns processing activity was moderate across Q1 2024, with 15 return events logged totaling 793 units returned. The overall restock rate of approximately 81.8% indicates that the majority of returned goods were graded as resalable and re-entered active inventory. PixelWear Apparel recorded the highest absolute return volumes and also experienced the highest disposal rate on a per-return basis. TrekMate Outdoors had the fewest returns, consistent with its lower outbound volumes.

The operations team should monitor disposal rates by client and SKU in Q2 to identify any quality or packaging issues driving above-average unit loss.

**Data Fields Used:** returns_processing.client_id, returns_processing.return_date, returns_processing.units_returned, returns_processing.units_restocked, returns_processing.units_disposed, returns_processing.returns_fee, clients.client_name

---

## Section 6: Carrier and Service Level Mix

Three primary carriers were active across SwiftHold's outbound shipment network in Q1 2024: FedEx, UPS, and USPS. UPS Ground was the dominant service for high-volume clients such as Brightline Beauty and Verde Nutrition. USPS Priority was used exclusively by PixelWear Apparel, appropriate for its lightweight garment SKUs. TrekMate Outdoors utilized FedEx Express for all shipments, reflecting premium delivery expectations for outdoor equipment.

This carrier mix appears well-aligned to client segment profiles and shipping zone distributions. A formal carrier cost-per-shipment analysis is recommended for Q2 contract negotiations.

**Data Fields Used:** outbound_shipments.carrier, outbound_shipments.service_level, outbound_shipments.shipping_zone, outbound_shipments.orders_shipped, outbound_shipments.fulfillment_fee, outbound_shipments.client_id

---

## Appendix & Notes

### Assumptions
- Inventory snapshot data represents end-of-month positions only; intra-month fluctuations are not captured.
- Fulfillment fees are SwiftHold's service charges and do not include carrier freight costs passed through to clients.
- Restock rate is calculated as units_restocked divided by units_returned across all return events in the period.
- All shipment batch records represent consolidated daily or bi-weekly shipment runs rather than individual parcel-level records.
- NovaSound Electronics is excluded from all Q1 reporting as their account status is Inactive.

### Known Limitations
- No parcel-level shipment data is available; analysis is at batch/event level.
- Carrier cost (freight charge) data is not stored in the schema, limiting cost-per-shipment benchmarking.
- No on-time delivery or shipment exception data is available.
- SKU-level outbound shipment attribution is not captured; shipments are linked to clients only.
- Returns are not linked to specific original outbound shipments.

### Recommended Next Analysis
- Add parcel-level tracking to enable on-time delivery and exception rate reporting.
- Conduct SKU-level inventory velocity analysis to flag stockout risk items.
- Integrate carrier cost data to compare fulfillment fees against freight spend by zone.
- Develop returns root-cause categorization for quality trend analysis.
- Model Q2 capacity utilization projections based on Q1 growth trends.

---
*Report generated by SwiftHold Logistics – Operations Analytics | Confidential – Internal Use Only*
