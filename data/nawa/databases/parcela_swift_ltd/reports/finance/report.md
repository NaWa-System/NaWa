# Q1 2024 Revenue and Depot Profitability Analysis

**Organisation:** Parcela Swift Ltd.
**Reporting Period:** January 2024 – March 2024
**Report Type:** Finance — Revenue & Profitability
**Prepared by:** Finance & Analytics Team
**Date of Issue:** April 2024

---

## Executive Summary

Parcela Swift Ltd. delivered a financially strong first quarter in 2024, with total network revenue growing consistently from January through to March across all five depot locations. London Gateway Depot retained its position as the primary revenue engine of the business, while Birmingham Central demonstrated the most improved revenue-to-cost ratio across the quarter. Every depot recorded a positive gross contribution in each reporting month, confirming that no part of the network was operating below cost recovery threshold during the period.

Operating costs grew broadly in line with shipment volume increases. However, the Dublin Express Depot continued to exhibit a structurally higher cost-to-revenue ratio than its UK counterparts, attributable to its fully contracted vehicle fleet and the administrative overhead associated with cross-border logistics operations. This dynamic is expected to persist unless addressed through targeted pricing adjustments or a transition toward partly owned fleet capacity in Dublin.

The Freight Pallet service tier generated the highest revenue per consignment across the quarter, with individual bookings from CrestMed Pharmaceuticals and Ferngrove Organics consistently exceeding £95 per shipment. Two unresolved Freight Pallet exception cases at quarter-end — including one involving a declared consignment value of £4,500 — represent a contingent financial liability requiring provisioning before Q1 accounts are finalised.

Heading into Q2, the revenue growth trajectory is encouraging. Management should focus on sustaining the Birmingham Central margin improvement, addressing the Dublin cost structure, and resolving the two highest-exposure exception cases promptly to protect the otherwise strong Q1 financial outcome.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Network Revenue (Q1 2024) | £108,320 | Aggregated across all five depots for January–March 2024. |
| Total Network Operating Cost (Q1 2024) | £79,200 | Cost growth broadly tracked volume. Before central overhead. |
| Network Gross Margin | 26.9% | (Revenue - Operating Cost) / Revenue. Before central overhead. |
| Highest Revenue Depot (Q1 Total) | London Gateway — £41,980 | Driven by B2B volume and premium service mix. |
| Best Gross Margin Depot | Birmingham Central — ~28.5% | Owned HGV and high B2B contract density. |
| Lowest Gross Margin Depot | Dublin Express — ~20.4% | Contracted fleet and cross-border overhead. |
| Revenue Growth (Jan to Mar) | +25.3% | From approx. £39,390 in January to £50,610 in March. |
| Contingent Claims Liability (Estimate) | Up to £4,500 | Based on declared value of shipment 1027 (CrestMed). Subject to policy terms. |

---

## 1. Revenue Performance by Depot

London Gateway generated the highest revenue in each of the three reporting months, supported by Halsworth Retail Group, Consumer Direct Pool, and a high-value Freight Pallet booking in February. Birmingham Central grew materially in February and March as Voltline Tech Solutions activity increased alongside CrestMed's freight pallet schedule. Manchester North showed consistent growth, while Glasgow Hub and Dublin Express both recorded month-on-month revenue increases across the quarter. Total network revenue grew approximately 25.3% between January and March.

*Data fields: depot_performance.total_revenue_gbp, depot_performance.report_month, depots.depot_name, regions.region_name*

---

## 2. Operating Cost Analysis by Depot

Total operating costs rose proportionally with shipment volumes, confirming the predominantly variable nature of Parcela Swift's cost base. Dublin Express exhibited the most unfavourable cost-to-revenue ratio throughout Q1, driven by fully contracted fleet and cross-border overheads. Glasgow Hub carried elevated costs relative to revenue in January, improving as volumes grew. Birmingham Central demonstrated the most controlled cost management, with operating costs growing more slowly than revenue in each successive month.

*Data fields: depot_performance.operating_cost_gbp, depot_performance.total_revenue_gbp, depots.depot_name, vehicles.owned_or_contracted*

---

## 3. Gross Margin by Depot and Month

All five depots recorded positive gross contributions in every month of Q1 2024. Network gross margin averaged 26.9% before central overhead. London Gateway and Birmingham Central consistently outperformed this average. Manchester North performed at approximately the network average. Glasgow Hub's margin was weaker in January but improved as volumes increased. Dublin Express remained the lowest-margin depot for the full quarter — a structural issue requiring a pricing or fleet strategy response rather than an operational fix.

*Data fields: depot_performance.total_revenue_gbp, depot_performance.operating_cost_gbp, depot_performance.depot_id, depots.depot_name, depot_performance.report_month*

---

## 4. Revenue by Service Type

Freight Pallet bookings contributed the highest revenue per consignment, ranging between £95 and £120 per individual shipment. Next Day Express generated the highest cumulative revenue contribution by volume. Two Day Standard provided reliable mid-range income across multiple accounts. Economy Parcel, most commonly used by the Consumer Direct Pool, generated approximately £5 per booking. Returns Management showed a clear upward trend tied to Halsworth Retail Group, warranting a dedicated pricing and capacity review ahead of the post-Easter returns peak.

*Data fields: shipments.revenue_gbp, shipments.service_id, service_types.service_name, service_types.base_rate_gbp, shipments.shipment_date*

---

## 5. Key Account Revenue Contribution

Halsworth Retail Group was the most active account by shipment count, generating revenue across Next Day Express, Freight Pallet, and Returns Management. CrestMed Pharmaceuticals contributed significantly through high-value freight pallet bookings with declared values consistently exceeding £2,000. Ferngrove Organics submitted a £120 freight pallet booking in March. Voltline Tech Solutions and TinderBox Gifts Ltd. represent growing mid-tier accounts. The Consumer Direct Pool generated consistent but low-yield B2C volume.

*Data fields: customers.customer_name, shipments.revenue_gbp, shipments.service_id, shipments.declared_value_gbp, shipments.shipment_date*

---

## 6. Exception-Linked Financial Risk and Provisioning

Two unresolved exceptions carry direct financial implications requiring provisioning before Q1 accounts are closed:

- **Shipment 1027** — CrestMed Pharmaceuticals freight pallet. Declared value £4,500. Failed delivery due to vehicle breakdown at Birmingham Central. Claims review pending; compensation liability possible under freight policy.
- **Shipment 1019** — Cross-border parcel awaiting customs clearance. Holding and handling costs accruing. Potential delay compensation claim.

Additionally, shipment 1012 (resolved, February) required a replacement dispatched at no charge following transit damage — a direct P&L cost to be recorded against Birmingham Central.

*Data fields: delivery_exceptions.exception_type, delivery_exceptions.resolved, shipments.declared_value_gbp, shipments.revenue_gbp, customers.customer_name*

---

## Appendix

### Assumptions
- depot_performance totals are authoritative monthly financial figures.
- Gross margin calculated before central overhead allocation.
- Shipment-level revenue used for service and account analysis only.
- Claims exposure based on declared_value_gbp; actual liability subject to policy terms.

### Known Limitations
- Central overhead absent from schema; gross margin does not represent net operating margin.
- Fuel, wages, and maintenance not itemised; unit cost analysis is limited.
- Accounts receivable ageing not captured; cash flow reporting not possible.
- EUR/GBP exchange rate impacts on Dublin depot not modelled.

### Recommended Next Analysis
- Net margin analysis with central overhead allocation by depot revenue share.
- Accounts receivable ageing for all B2B clients, priority on CrestMed.
- Freight liability claims register for formal exposure tracking.
- Dublin Express pricing review against cross-border cost structure.
- Returns Management profitability review ahead of Q2 volume growth.

---
*Report prepared by the Parcela Swift Ltd. Finance & Analytics Team. For internal use only.*
