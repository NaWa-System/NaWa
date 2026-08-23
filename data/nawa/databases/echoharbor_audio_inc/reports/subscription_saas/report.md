# EchoHarbor Audio — Q1 2026 Subscription Growth & Billing Health Report

**Organisation:** EchoHarbor Audio, Inc.  
**Reporting period:** 2026-01-01 to 2026-03-31

## Executive Summary
During Q1 2026 (January 1 through March 31, 2026), EchoHarbor Audio continued to add new users across multiple acquisition channels, with meaningful premium adoption shortly after signup for several cohorts. The paid base remains concentrated in Premium Individual, with Premium Family contributing a smaller but higher-priced footprint.

Billing performance was generally stable for active paid subscriptions, with the primary risk signal in late Q1 being a failed premium invoice that may indicate payment method decay or localized payment processing issues. Cancellations in the quarter were limited and largely explainable (eligibility changes in Student; price sensitivity in Premium Individual), suggesting churn is currently driven by specific segments rather than broad product dissatisfaction.

From an operational standpoint, the combination of steady paid invoicing and a sizable free tier indicates room for targeted conversion work, especially in channels that bring in high-intent listeners. The most immediate revenue-protection opportunity is improving payment recovery flows for failed invoices and reducing involuntary churn risk before the next renewal window.

Overall, Q1 closes with a modest but healthy subscription base, a clear primary plan mix, and actionable levers in dunning/retry logic and plan positioning to improve net revenue retention into Q2 2026.

## Key Metrics (Q1 2026)
- **New Users:** 11
- **New Subscriptions Started:** 11
- **Paid Subscription Starts:** 8
- **Cancellations Recorded:** 2
- **Paid Invoices Issued:** 10
- **Paid Invoices Collected:** 9
- **Gross Billed Amount:** $105.90
- **Collected Amount:** $94.91
- **Failed Payment Events:** 1

## Main Sections
### 1) Subscriber Base Overview (End of Q1)
The plan mix is anchored by Premium Individual, with Premium Family representing fewer accounts but higher billed value per subscription. The free tier remains a meaningful share of accounts and continues to serve as a conversion pool for lifecycle marketing. Cancellations were limited and tied to identifiable segment drivers.

### 2) New User Acquisition Mix (Q1 Cohort)
Acquisition was spread across organic search, paid social, referral, podcast ads, and influencer sources, reducing over-reliance on any single channel. Early conversion-focused prioritization should emphasize intent-heavy channels (organic and referral) while improving onboarding for paid social and influencer cohorts.

### 3) Plan Starts and Conversion to Paid
Premium Individual is the primary paid entry point. Student plan churn appears eligibility-related, reinforcing the need for proactive upgrade messaging. Premium Family remains an underutilized lever; improved positioning and household prompts may lift adoption.

### 4) Billing Outcomes and Payment Reliability
Most billed invoices were collected successfully, indicating healthy payment reliability overall. A single failed premium invoice in late Q1 is an actionable signal to strengthen dunning, improve payment update prompts, and monitor risk by region/channel.

### 5) Cancellation Reasons and Preventable Churn Signals
Observed cancellation drivers suggest targeted interventions: eligibility-to-upgrade flows for Student and price/packaging options for price-sensitive premium users (e.g., annual billing, limited tier, or retention offers).

### 6) Listening Activity Signals (Engagement Proxy)
Sampled streams show multi-device usage (mobile, desktop, smart speaker, TV), supporting a listening footprint across contexts. Cross-device adoption is a positive engagement indicator and can be used to target premium retention and upsell opportunities.

## Appendix / Notes
**Assumptions**
- Billing totals are computed using invoice_date within the period.
- Collected totals include invoices with payment_status='paid'.
- Subscription starts include free and paid plans.

**Known limitations**
- No ad revenue, refunds, discounts, taxes, or annual plans are included.
- Streams are sampled and should be treated as directional.
- Plan changes over time are not captured.

**Recommended next analysis**
- Add invoice event/payment attempt tracking to measure dunning performance.
- Build signup cohorts and retention curves by acquisition channel and region.
- Model free-to-paid conversion timing vs. early listening engagement.
