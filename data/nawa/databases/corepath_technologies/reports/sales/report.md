# Q1–Q2 2024 Hardware Sales & Revenue Performance Report

**Organisation:** Corepath Technologies  
**Reporting Period:** January 1, 2024 – April 30, 2024  
**Prepared by:** Business Intelligence & Sales Operations  
**Date of Issue:** May 2024  

---

## Executive Summary

This report presents an analysis of Corepath Technologies' hardware sales activity across the first four months of fiscal year 2024 (January through April). During this period, the business processed nineteen fulfilled hardware sales orders across ten enterprise accounts, generating substantial product revenue with healthy gross margins. The pipeline demonstrated consistent momentum month-over-month, with April shaping up to be the strongest month by order volume and projected revenue.

Mac Laptops — particularly the MacBook Pro 14-inch M3 Pro and MacBook Pro 16-inch M3 Max — remained the dominant revenue-generating category, reflecting continued customer preference for high-performance portable workstations. iPad and iPhone devices contributed meaningfully to deal diversification, while the Apple Vision Pro order placed by Vertex Software Labs in February represents the first enterprise adoption of that product class in the portfolio and warrants close attention as a strategic growth signal.

Two accounts — Vertex Software Labs and Axiom Financial Partners — accounted for a disproportionate share of hardware order value, representing a concentration risk the sales team should address through active pipeline development in the mid-tier customer base. The account managed by James Roark delivered the highest revenue contribution, while the West region led all geographies in fulfilled order volume.

One order (Halcyon Media Inc, March) was cancelled. One invoice (Stonewall Legal LLP) has moved to overdue status, and three April invoices remain outstanding. Receivables management should be prioritised before end of Q2.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Fulfilled Orders | 19 Orders | Across 10 accounts. 1 cancelled, 1 pending. |
| Gross Hardware Revenue (Fulfilled) | ~$596,600 | Sum of fulfilled hardware sale invoices, Jan–Apr. |
| Estimated Gross Profit Margin | ~27–32% | Based on unit_cost vs. unit_price; before discount. |
| Top Revenue Account | Axiom Financial Partners | Three hardware orders totalling over $115,000. |
| Top Sales Representative | James Roark | Highest aggregate fulfilled order value in period. |
| Leading Product Category | Mac Laptops | Dominant across order frequency and revenue. |
| Average Discount Applied | ~4.2% | Range: 0%–10%; concentrated in Platinum accounts. |
| Overdue / Outstanding Invoices | 4 Invoices | 1 overdue, 3 outstanding (April). |
| West Region Order Share | ~47% of Orders | Driven by Vertex Software Labs and Arclight Education Trust. |

---

## Report Sections

### 1. Monthly Sales Order Volume & Trend

Order volume remained strong and showed clear upward momentum across the reporting period. January saw four fulfilled orders establishing a solid baseline. February matched this with five fulfilled orders including a notable Apple Vision Pro deployment. March delivered five fulfilled orders alongside one cancellation and one pending order, reflecting some mid-quarter volatility. April recorded four fulfilled orders but with notably larger average order values, suggesting the sales team is securing larger fleet refresh engagements as the year progresses.

The sequential growth in order count and average deal size signals healthy pipeline conversion rates. The single cancellation in March should prompt a review of qualification criteria for the Halcyon Media Inc account.

**Data sources:** `sales_orders.order_id`, `sales_orders.order_date`, `sales_orders.status`, `sales_orders.customer_id`

---

### 2. Revenue by Product Category

Mac Laptops dominated revenue contribution across all four months, with the MacBook Pro 14-inch M3 Pro and MacBook Pro 16-inch M3 Max together appearing in eleven of the nineteen fulfilled orders. Mac Desktops represented a secondary tier, popular with customers expanding shared workspace environments. iPad and iPhone devices featured in several orders as part of broader device ecosystem deployments.

Emerging Devices — represented by the Apple Vision Pro order — remains nascent but strategically important. Professional Services and Support & Warranty add-ons appeared in approximately half of all orders, contributing higher-margin incremental revenue at relatively low cost of goods.

**Data sources:** `order_items.order_id`, `order_items.product_id`, `order_items.quantity`, `order_items.unit_price`, `order_items.unit_cost`, `products.category`, `products.product_name`

---

### 3. Sales Performance by Account Manager

James Roark managed the largest revenue-contributing accounts, including Axiom Financial Partners and Vertex Software Labs — both Platinum tier. Sarah Lund demonstrated strong order frequency with consistent activity across Arclight Education Trust, Meridian Creative Group, and NovaBridge Health Systems. Priya Nair showed activity across three accounts, though the Halcyon Media Inc cancellation reduced her net fulfilled order count. Building out Priya's pipeline with higher-tier accounts may improve revenue consistency in Q3.

**Data sources:** `sales_orders.sales_rep`, `sales_orders.order_id`, `sales_orders.status`, `sales_orders.discount_pct`, `customers.tier`, `customers.company_name`

---

### 4. Regional Sales Distribution

The West region led all shipping regions in fulfilled order count, driven by Vertex Software Labs and Arclight Education Trust. The East region followed closely, anchored by Axiom Financial Partners and Redstone Ventures. The Central region generated consistent deal flow through NovaBridge Health Systems and ClearPath Logistics. No new customer acquisition occurred in any region during this period, suggesting new business development should be a Q3 priority.

**Data sources:** `sales_orders.shipping_region`, `sales_orders.order_id`, `sales_orders.status`, `customers.region`, `customers.company_name`

---

### 5. Gross Margin Analysis by Product Line

Mac Laptops delivered consistent per-unit margin spreads of approximately $400–$800 depending on model. The highest gross margin percentage items were Professional Services (Apple Business Essentials Setup at ~67%) and Support & Warranty (AppleCare+ for Enterprise at ~50%). Apple Vision Pro carried the largest absolute per-unit gross margin at $700. Discount application by Platinum tier accounts (up to 10%) modestly compressed realized margins but remained within contractual norms. Encouraging add-on attach rates should be a key commercial focus.

**Data sources:** `order_items.unit_price`, `order_items.unit_cost`, `order_items.quantity`, `products.category`, `products.product_name`, `sales_orders.discount_pct`

---

### 6. Invoice & Accounts Receivable Status

The majority of hardware invoices were paid within net-15 terms, reflecting a prompt-paying customer base. However, one invoice issued to Stonewall Legal LLP (due April 9) has moved to Overdue status. Three April hardware invoices for Axiom Financial Partners, NovaBridge Health Systems, and Arclight Education Trust remain Outstanding with due dates approaching in early May. The accounts receivable team should escalate the overdue item and set follow-up reminders for April outstanding balances.

**Data sources:** `invoices.invoice_id`, `invoices.customer_id`, `invoices.order_id`, `invoices.invoice_date`, `invoices.due_date`, `invoices.paid_date`, `invoices.amount`, `invoices.status`, `invoices.invoice_type`, `customers.company_name`

---

## Appendix & Notes

### Assumptions
- Revenue figures are based on invoiced amounts from the invoices table.
- Gross margin calculations use unit_price and unit_cost from order_items.
- The cancelled order (Order 1012, Halcyon Media Inc) is excluded from all revenue calculations.
- The pending order (Order 1015, Stonewall Legal LLP) is excluded from fulfilled revenue totals.
- All dates are based on order_date and invoice_date fields.

### Known Limitations
- No pipeline or opportunity-stage data exists; lead-to-close conversion rates cannot be calculated.
- Subscription revenue is reported separately and excluded here.
- Customer-level profitability cannot be fully assessed without overhead allocation.
- Line-item-level discount variation is not captured in the schema.

### Recommended Next Analysis
- Customer cohort analysis tracking average spend per account over rolling 12-month windows.
- Sales rep performance scorecard including deal velocity, average order value, and discount rate.
- Pipeline tracking to measure lead-to-order conversion and forecast Q3 hardware revenue.
- Cross-sell attach rate analysis for AppleCare+ and Professional Services bundling.
- Root cause review of the Halcyon Media Inc cancellation and Silver tier churn risk assessment.

---
*Report generated by Corepath Technologies Business Intelligence. For internal use only.*
