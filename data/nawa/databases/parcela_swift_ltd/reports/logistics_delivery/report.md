# Q1 2024 Delivery Operations Performance Report

**Organisation:** Parcela Swift Ltd.
**Reporting Period:** January 2024 – March 2024
**Report Type:** Logistics / Delivery Operations
**Prepared by:** Operations Analytics Team
**Date of Issue:** April 2024

---

## Executive Summary

Parcela Swift Ltd. recorded a broadly positive first quarter in 2024, with total shipment volumes growing month-on-month across all five depots and overall on-time delivery performance remaining above the company's internal SLA benchmark for the majority of the period. The London Gateway Depot continued to lead the network in absolute shipment volumes, while the Dublin Express Depot demonstrated meaningful improvement in delivery reliability as the quarter progressed.

The quarter was nonetheless marked by operational challenges that warrant management attention. Eight delivery exceptions were logged across the network, spanning causes including vehicle breakdown, sorting errors, recipient unavailability, and an ongoing cross-border customs delay. As of the reporting date, four exceptions remain unresolved, representing a residual risk requiring active case management from respective depot supervisors before Q2 commences.

The Glasgow Hub recorded the weakest on-time delivery rate relative to its volume in January and February, with partial recovery observed in March. The Freight Pallet service category generated the highest revenue per consignment across all service tiers but also accounted for the two most commercially significant unresolved exception cases at quarter-end.

Forward-looking, the month-on-month volume trajectory suggests that London Gateway and Manchester North may face capacity pressure during Q2 peak weeks. A structured capacity planning review is recommended ahead of the Easter and early summer peak periods.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Network Shipments (Q1 2024) | 908 | Jan: 310, Feb: 338, Mar: 380. Consistent growth across all depots. |
| Network On-Time Delivery Rate | 88.6% | Above internal SLA minimum of 87%. Improving trend observed. |
| Total Failed Deliveries | 39 | Glasgow Hub recorded the highest failure rate in January. |
| Open Delivery Exceptions | 4 | Four cases unresolved as of 31 March 2024. |
| Highest-Frequency Service Type | Next Day Express | Dominant by shipment count across B2B accounts. |
| Highest Revenue Per Shipment | Freight Pallet — avg. ~£103 | Driven by CrestMed Pharmaceuticals and Ferngrove Organics. |
| Shipment Volume Growth (Jan–Mar) | +22.6% | From 310 to 380 shipments network-wide. |
| Exception Resolution Rate | 50% | 4 of 8 exceptions resolved within the quarter. |

---

## 1. Monthly Shipment Volume Trends

Shipment volumes across the Parcela Swift network increased consistently throughout Q1 2024. London Gateway Depot processed the highest absolute volumes each month, benefitting from its proximity to major retail and e-commerce clients including Halsworth Retail Group. Birmingham Central and Manchester North recorded steady mid-tier volumes. Glasgow Hub and Dublin Express demonstrated improving throughput as the quarter progressed.

The network-wide increase from 310 shipments in January to 380 in March reflects both organic expansion of existing accounts and the ramping activity of Voltline Tech Solutions, onboarded at Birmingham Central in June 2023.

*Data fields: depot_performance.total_shipments, depot_performance.report_month, depots.depot_name, shipments.shipment_date*

---

## 2. On-Time Delivery Performance by Depot

Network on-time delivery performance averaged 88.6% across Q1 2024, within Parcela Swift's contracted SLA minimum of 87%. London Gateway maintained the strongest performance above 91% across all three months. The Glasgow Hub underperformed in January at approximately 85.7%, recovering to 91.7% in February and continuing to improve in March. Dublin Express achieved consistent rates above 90% throughout the period. Manchester North showed a marginal dip in March coinciding with two recorded exception cases.

*Data fields: depot_performance.on_time_deliveries, depot_performance.total_shipments, depot_performance.failed_deliveries, depots.depot_name, depot_performance.report_month*

---

## 3. Delivery Exception Analysis

Eight delivery exceptions were recorded across the network in Q1 2024, covering missed collections, address-not-found incidents, recipient unavailability, transit damage, a customs delay, a route deviation, a vehicle breakdown, and a sorting error.

Highest-risk unresolved cases:
- **Shipment 1027** — CrestMed Pharmaceuticals freight pallet, vehicle breakdown at Birmingham Central. Customer notified; resolution pending.
- **Shipment 1034** — London Gateway sorting error logged 29 March 2024. Investigation underway.

The exception rate remains below 1% of total shipments, but the concentration of open cases in March warrants close monitoring heading into Q2.

*Data fields: delivery_exceptions.exception_type, delivery_exceptions.resolved, delivery_exceptions.resolution_notes, shipments.status, customers.customer_name*

---

## 4. Service Type Utilisation

Next Day Express was the most utilised service by shipment count, driven by time-sensitive B2B accounts. Two Day Standard served cost-efficient mid-tier clients. Economy Parcel dominated B2C volume through the Consumer Direct Pool. Freight Pallet, while lower in frequency, generated approximately £103 per consignment on average — the highest yield of any service tier. Returns Management showed growing uptake from Halsworth Retail Group, suggesting commercial development potential in Q2.

*Data fields: service_types.service_name, service_types.base_rate_gbp, shipments.service_id, shipments.revenue_gbp, shipments.shipment_date*

---

## 5. Customer Shipment Activity

Halsworth Retail Group and CrestMed Pharmaceuticals were the two highest-volume B2B customers by both shipment count and revenue contribution. CrestMed's freight pallet consignments carry the highest declared values in the dataset, underlining the commercial sensitivity of this account. TinderBox Gifts Ltd. experienced two late deliveries, both through Manchester North, suggesting a potential collection scheduling issue at that depot. Cairn Fine Foods showed improving on-time rates in February and March following a failed delivery in January.

*Data fields: customers.customer_name, shipments.status, shipments.revenue_gbp, shipments.service_id, shipments.depot_id*

---

## 6. Fleet and Depot Capacity Overview

Parcela Swift operates ten vehicles across five depots — Transit Vans (800 kg) and Heavy Goods Vehicles (4,500–5,000 kg). London Gateway holds the largest fleet at three owned vehicles. Three of ten fleet vehicles are contracted, concentrated at Birmingham Central, Manchester North, and Dublin Express. The vehicle breakdown in March at Birmingham involving a contracted van highlights the risk of contracted fleet dependency. A formal contracted fleet reliability audit is recommended as a Q2 priority.

*Data fields: vehicles.vehicle_type, vehicles.capacity_kg, vehicles.owned_or_contracted, depots.depot_name, delivery_exceptions.exception_type*

---

## Appendix

### Assumptions
- depot_performance figures are treated as authoritative monthly aggregates.
- On-time delivery defined as actual_delivery_date ≤ promised_delivery_date.
- Shipments with status 'In Transit' excluded from on-time calculations.
- Consumer Direct Pool represents aggregated B2C demand, not a single account.

### Known Limitations
- The shipments table is a transactional sample; full volume is in depot_performance.
- Fuel, labour, and maintenance costs are not individually captured in the schema.
- Cross-border customs compliance metrics cannot be fully reported from available data.
- Vehicle utilisation rates are not calculable from the current schema.

### Recommended Next Analysis
- Root-cause investigation for late deliveries at Manchester North Depot.
- Capacity planning review for London Gateway and Manchester North ahead of Q2.
- Customer satisfaction scoring linked to exception records.
- Contracted vs. owned vehicle reliability benchmarking.
- Service type profitability modelling once cost-per-shipment tracking is implemented.

---
*Report prepared by the Parcela Swift Ltd. Operations Analytics Team. For internal use only.*
