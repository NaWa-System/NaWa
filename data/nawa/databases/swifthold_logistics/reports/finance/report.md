# Q1 2024 Client Billing & Revenue Summary Report

**Organisation:** SwiftHold Logistics  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Finance  
**Prepared By:** SwiftHold Finance & Analytics Team  
**Date Issued:** April 2024

---

## Executive Summary

SwiftHold Logistics generated total billed revenue of approximately $76,010 across five active clients during Q1 2024, reflecting a broadly stable quarter with modest growth in fulfillment fee revenue driven by rising outbound volumes in the beauty and apparel segments. Monthly billing records across January, February, and March show consistent revenue contribution from all active accounts, with no client recording a significant month-on-month billing decline.

Fulfillment fees represented the largest component of total billed revenue, consistent with the company's usage-based model where outbound order volume is the primary cost driver for clients. PixelWear Apparel and Brightline Beauty emerged as the two highest-billing clients by total quarterly revenue. All January and February invoices are recorded as Paid, which is a positive indicator of client payment health.

A notable concern entering Q2 is the Pending payment status of three March billing records, representing approximately $16,555 in outstanding receivables. Management should also evaluate whether value-added service adoption can be expanded across clients currently billing zero in that category, as this represents a clear upsell opportunity within the existing account base.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Q1 Billed Revenue | $76,010.00 | Sum of total_billed across all 15 billing records, Q1 2024. |
| Total Fulfillment Fee Revenue (Q1) | $44,755.00 | Largest revenue component; driven by high outbound order volumes. |
| Total Storage Fee Revenue (Q1) | $8,862.50 | Declined modestly month-on-month as inventory levels trended down. |
| Total Receiving Fee Revenue (Q1) | $4,050.00 | Consistent with 15 inbound receipt events across both DCs. |
| Total Value-Added Fee Revenue (Q1) | $2,060.00 | Steady but modest; PixelWear Apparel billed $0 in this category. |
| Outstanding Receivables | ~$16,555.00 | Three March invoices in Pending status as of report date. |
| Highest Billing Client (Q1) | PixelWear Apparel – ~$19,537.50 | Driven by high outbound order volumes and consistent receiving activity. |
| Average Monthly Billing per Client | ~$5,067.33 | Total Q1 revenue divided by 15 client-month billing records. |
| Payment Collection Rate (Jan–Feb) | 100% | All 10 billing records for Jan and Feb 2024 are Paid. |
| Month-on-Month Revenue Trend | Stable to slightly growing | March billing slightly ahead of January and February. |

---

## Section 1: Total Revenue by Client

PixelWear Apparel and Brightline Beauty were SwiftHold's highest-revenue clients in Q1 2024, each billing approximately $19,538 and $18,933 respectively across the three-month period. Verde Nutrition ranked third with approximately $18,330 in total billed fees, supported by a combination of significant storage and receiving fees from its pallet-heavy inventory profile. Lumos Home Goods and TrekMate Outdoors represented the lower billing tier at approximately $9,400 and $10,245 respectively.

The billing distribution indicates meaningful client concentration risk, with the top two clients representing close to half of total Q1 revenue. Management should consider account retention strategies as a Q2 priority.

**Data Fields Used:** monthly_billing.client_id, monthly_billing.billing_month, monthly_billing.total_billed, clients.client_name, clients.industry_segment

---

## Section 2: Revenue Composition by Fee Type

Fulfillment fees dominated the revenue mix in Q1 2024 at approximately 59% of all billed revenue. Storage fees contributed approximately 12%, receiving fees approximately 5%, and value-added service fees approximately 3%. The remaining portion comprises minor rounding across fee categories.

The concentration of revenue in fulfillment fees means that SwiftHold's top-line is closely correlated with client order volumes, making outbound shipment trends a leading indicator for revenue forecasting.

**Data Fields Used:** monthly_billing.storage_fee, monthly_billing.fulfillment_fee, monthly_billing.receiving_fee, monthly_billing.value_added_fee, monthly_billing.total_billed, monthly_billing.billing_month

---

## Section 3: Monthly Revenue Trend

January 2024 established the baseline at approximately $25,215 across five clients. February remained broadly flat at approximately $24,895, reflecting a slight reduction in storage fees consistent with declining inventory levels and marginally lower receiving activity. March showed a modest improvement to approximately $25,900, driven by growth in fulfillment fees as outbound volumes increased for Brightline Beauty, PixelWear Apparel, and Verde Nutrition.

The positive trajectory into March is encouraging and, if maintained, suggests potential for organic revenue growth in Q2 without requiring new client acquisition.

**Data Fields Used:** monthly_billing.billing_month, monthly_billing.total_billed, monthly_billing.fulfillment_fee, monthly_billing.storage_fee, monthly_billing.client_id

---

## Section 4: Payment Status and Receivables Analysis

All January and February 2024 invoices across all five active clients are recorded as Paid, representing a clean receivables position for the first two months of Q1. However, three of the five March billing records remain Pending as of the report date:

- **Lumos Home Goods:** $3,080.00
- **PixelWear Apparel:** $6,730.00
- **Brightline Beauty:** $6,745.00

**Total Outstanding Receivables: ~$16,555.00**

Given that all prior month invoices were paid on time, this pending status is likely a timing issue rather than a credit risk concern. The finance team should initiate standard collection follow-up if these remain unpaid beyond agreed payment terms.

**Data Fields Used:** monthly_billing.billing_id, monthly_billing.client_id, monthly_billing.billing_month, monthly_billing.total_billed, monthly_billing.payment_status, clients.client_name

---

## Section 5: Storage Fee Revenue and Inventory Correlation

Storage fee revenue declined modestly across Q1 2024 as aggregate inventory levels trended downward at both distribution centers. Pallet occupancy data from inventory snapshots confirms that pallets occupied decreased across most SKUs from January through March, directly correlating with observed storage fee declines per client.

Verde Nutrition consistently generated the highest storage fees due to its pallet-dominant inventory profile, while Brightline Beauty generated the lowest storage fees relative to its total billing. If clients replenish inventory aggressively in Q2 to protect against stockout risk, storage fee revenue could recover and potentially exceed Q1 levels.

**Data Fields Used:** monthly_billing.storage_fee, monthly_billing.client_id, monthly_billing.billing_month, inventory_snapshots.pallets_occupied, inventory_snapshots.snapshot_date, skus.client_id, clients.client_name

---

## Section 6: Value-Added Services Revenue and Upsell Opportunity

Value-added services generated $2,060 in Q1 2024. Lumos Home Goods, Verde Nutrition, TrekMate Outdoors, and Brightline Beauty each billed consistent value-added fees in the range of $100–$300 per month. PixelWear Apparel was the only active client recording zero value-added fees for the entire quarter despite being the highest-billing client overall.

There is a clear upsell opportunity both to deepen service adoption among current users and to engage PixelWear Apparel—a high-volume, high-frequency client—in at least one value-added service offering in Q2.

**Data Fields Used:** monthly_billing.value_added_fee, monthly_billing.client_id, monthly_billing.billing_month, clients.client_name, clients.industry_segment

---

## Appendix & Notes

### Assumptions
- All billing records represent finalized invoices issued at the end of each calendar month.
- Pending status indicates invoices issued but not yet confirmed as cleared as of the report preparation date.
- Value-added fees are billed on an agreed per-service rate basis, recorded as monthly aggregates.
- Storage fees are calculated based on average pallet occupancy, proxied by end-of-month snapshot data.
- NovaSound Electronics generated no billing activity in Q1 2024 and is excluded from all analysis.

### Known Limitations
- Monthly billing records are stored as aggregates; line-item invoice detail is not available in the current schema.
- No cost-of-service data is stored, making gross margin analysis impossible without supplementary data.
- Storage fees are approximated from end-of-month snapshots; daily average pallet occupancy would be more accurate.
- No contractual minimum volume data is available, limiting ARR or MRR forecasting.
- Currency is assumed to be USD throughout.

### Recommended Next Analysis
- Build a client profitability model incorporating labor costs, DC overhead allocation, and carrier freight costs.
- Develop a client concentration risk dashboard tracking revenue contribution percentages over time.
- Model Q2 revenue forecasts using Q1 outbound shipment growth rates as a fulfillment fee proxy.
- Initiate a value-added services upsell analysis targeting PixelWear Apparel.
- Implement invoice aging reporting with alerts for invoices remaining Pending beyond 30 days.

---
*Report generated by SwiftHold Logistics – Finance & Analytics Team | Confidential – Internal Use Only*
