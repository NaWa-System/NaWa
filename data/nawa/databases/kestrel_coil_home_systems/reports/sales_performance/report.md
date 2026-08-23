# Q1 2026 Sales Performance & Channel Mix (Jan–Mar 2026)

**Organisation:** Kestrel & Coil Home Systems  
**Reporting Period:** 2026-01-01 to 2026-03-31  

## Executive Summary
Q1 2026 demand was led by trade/installer and big-box retail accounts, with direct online contributing steady consumer volume. The quarter shows a healthy mix of higher-ticket kitchen products (refrigeration and cooking) alongside repeat-through retail staples (dishwashers and microwaves).

Product mix skewed toward dishwashing and cooking in wholesale channels, while direct online orders concentrated on single-unit consumer replacements (laundry and dishwashing). Discounting remained present in wholesale transactions, particularly for larger retailer and installer orders, but generally stayed within a controlled band.

Operationally, the order book remained largely deliverable within the quarter, with a limited number of late-quarter orders still in transit or booked for early Q2 fulfillment. One cancellation occurred late in the period, suggesting an opportunity to tighten pre-shipment confirmation for large wholesale baskets.

Overall, the data supports a strategy of protecting margin on higher-feature kitchen products while using targeted, volume-based discounts on dishwashers and bundled packages to maintain retailer and installer momentum.

## Key Metrics
- **Total Gross Sales (Booked, incl. Cancelled):** $143,474.30  
  - Sum of Q1 order item revenue after discounts across all Q1 orders, including one cancelled order.
- **Total Gross Sales (Delivered Only):** $129,280.90  
  - Delivered revenue recognized in Q1; excludes cancelled and non-delivered activity.
- **Delivered Orders (Count):** 12  
  - Number of delivered orders in the period.
- **Average Discount Rate (Wholesale-heavy mix):** Approx. 4–7% on major wholesale lines  
  - Wholesale lines show modest negotiated discounts; direct online shows little discounting.
- **Top Revenue Category (Delivered):** Dishwashing  
  - High unit volumes through retail partners.
- **Second Revenue Category (Delivered):** Cooking  
  - Strong value from induction ranges with hood bundles.
- **Channel Concentration:** Big-Box Retail + Installer/Trade dominate revenue  
  - Wholesale channels drive most revenue.
- **Cancellation Rate (Orders):** 1 of 13 Q1 orders (~8%)  
  - Small count but meaningful impact; merits monitoring.

## Findings & Analysis
### 1) Quarter Revenue Overview (Delivered vs. Booked)
Q1 revenue is primarily recognized in delivered orders, with a small share sitting in late-quarter pipeline due to shipment timing and one cancellation. This view separates booking activity from delivery execution.

The cancellation was tied to a large wholesale basket. A pre-ship confirmation step for large wholesale orders is recommended to reduce similar outcomes.

### 2) Revenue by Channel
Big-box retail generates repeatable unit volume across dishwashers and microwaves, while installer/trade is the primary engine for bundled kitchen packages. Direct online remains stable with smaller average baskets.

Action: prioritize partner health (assortment, in-stock discipline, bundle programs) while using direct online to protect pricing and capture consumer signals.

### 3) Revenue by Product Category
Dishwashing leads the quarter due to wholesale quantities and steady replenishment behavior. Cooking follows, supported by induction ranges and hood attachment.

Laundry and refrigeration are more episodic, aligning with replacement and project cycles. Small appliances provide add-on volume and can be used for bundles without diluting premium categories.

### 4) Top Products by Revenue and Units
Dishwashers are the primary volume driver. Induction ranges and refrigerators materially contribute to revenue due to higher selling prices.

Microwaves show meaningful unit volume and are well-suited for attach/bundle tactics.

### 5) Regional Mix and Notable Patterns
All regions contributed revenue. Installer-driven cooking bundles are particularly visible in the West, while the Northeast reflects retail replenishment behavior.

With limited history, signals are directional. Aligning field support and co-op activity by region/channel should improve sell-through.

### 6) Discounting & Pricing Discipline
Discounting is concentrated in wholesale, correlated with larger order sizes. Direct online pricing is held near list.

Recommendation: formalize tiered discount guidance by channel/category, and monitor the impact on delivered revenue and downstream service costs.

## Appendix / Notes
**Assumptions**
- Revenue = quantity × unit_price × (1 − discount_pct/100).
- Delivered revenue uses orders with `order_status = 'Delivered'`.
- Cancelled orders are included in booked totals but excluded from delivered totals.

**Known Limitations**
- Returns/refunds/rebates are not captured.
- Shipping costs and promotional spend are not captured.
- Customer demographics and marketing attribution are not available.

**Recommended Next Analysis**
- Add returns to quantify net revenue and return rates by category/channel.
- Calculate gross margin using product `unit_cost` vs realized net price.
- Analyze lead times (order to delivery) by channel/region.
