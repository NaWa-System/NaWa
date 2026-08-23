# Q1–Q2 2024 Managed Services Subscription Health & Recurring Revenue Report

**Organisation:** Corepath Technologies  
**Reporting Period:** January 1, 2024 – April 30, 2024  
**Prepared by:** Business Intelligence & Customer Success  
**Date of Issue:** May 2024  

---

## Executive Summary

This report provides a comprehensive view of Corepath Technologies' managed services subscription business across the first four months of 2024. The subscription portfolio currently comprises nine active accounts following the churn of Halcyon Media Inc in January 2024, collectively covering over 1,340 enrolled devices across four service plan tiers. Monthly Recurring Revenue from subscription fees has remained stable, with no new subscription additions recorded during the period — a notable finding that underscores the need for renewed new-logo subscription acquisition efforts in Q3.

The two Platinum tier subscribers — Axiom Financial Partners and Vertex Software Labs — together generate the majority of subscription MRR and represent the highest strategic value accounts in the portfolio. Both accounts have maintained consistent payment behaviour and hold multi-hundred-device footprints, indicating deep platform dependency and low near-term churn risk.

Support ticket activity reflected expected demand patterns for an Apple-focused managed services provider. Hardware Fault and MDM Enrollment tickets accounted for the majority of volume and the longest resolution times. Two tickets remain open as of the report date, including one High priority Hardware Fault for Vertex Software Labs that requires immediate attention.

Subscription invoice collection was strong throughout the period. One April subscription invoice for Stonewall Legal LLP remains outstanding, consistent with a broader receivables issue at that account that leadership should assess.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Active Subscriptions | 9 Accounts | 1 churned (Halcyon Media Inc). No new subscriptions added. |
| Total Enrolled Devices (Active) | ~1,340 Devices | Vertex Software Labs (510) and Axiom Financial Partners (320) are largest fleets. |
| Monthly Recurring Revenue (MRR) | ~$12,292 | Stable across all four months. No expansion or new additions. |
| Annualised Recurring Revenue (ARR) Run Rate | ~$147,504 | MRR x 12; based on current active subscriptions. |
| Churn Events (Period) | 1 Account | Halcyon Media Inc, Basic tier, 20 devices, January 2024. |
| Subscription Invoice Collection Rate | ~97% | All invoices paid except one outstanding April invoice (Stonewall Legal LLP). |
| Total Support Tickets Raised | 22 Tickets | 19 closed, 3 open as of report date. |
| Avg Resolution Time (All Priorities) | ~15.9 Hours | High-priority tickets averaged ~35 hours, driven by hardware fault cases. |
| Tickets: Hardware Fault Category | 7 Tickets (32%) | Largest single category; longest average resolution time at ~39 hours. |

---

## Report Sections

### 1. Subscription Portfolio Overview & MRR Composition

The active portfolio spans four plan tiers. The two Elite plan accounts (Axiom Financial Partners and Vertex Software Labs) each pay $2,999 per month, together contributing nearly 49% of total MRR. The two Enterprise tier subscribers (Arclight Education Trust and Redstone Ventures) at $1,499 per month each represent approximately 24% of MRR. Remaining Standard and Basic tier accounts contribute the balance. Concentration in two accounts creates meaningful MRR risk if either Platinum subscriber were to downgrade or churn, reinforcing the importance of multi-year contract discussions with these accounts.

**Data sources:** `subscriptions.subscription_id`, `subscriptions.plan_id`, `subscriptions.status`, `subscriptions.device_count`, `service_plans.plan_name`, `service_plans.plan_tier`, `service_plans.monthly_fee`, `customers.company_name`, `customers.tier`

---

### 2. Churn Analysis & Retention Health

The single churn event — Halcyon Media Inc, whose Basic tier subscription ended January 15, 2024 — resulted in the loss of $299 MRR and 20 managed devices. Net subscription retention for the period stands at zero new additions alongside one churn, meaning the active subscriber count declined by one. For a managed services business reliant on ARR growth, a sustained period of zero new additions is a structural concern. Management should review the Halcyon exit findings and set a Q3 new subscription acquisition target.

**Data sources:** `subscriptions.subscription_id`, `subscriptions.status`, `subscriptions.end_date`, `subscriptions.start_date`, `subscriptions.plan_id`, `service_plans.monthly_fee`, `service_plans.plan_tier`, `customers.company_name`

---

### 3. Device Fleet Coverage by Plan Tier

Approximately 1,340 devices are under active managed service coverage. Vertex Software Labs holds the largest fleet at 510 devices, followed by Axiom Financial Partners (320) and Arclight Education Trust (190). Both Elite plan accounts have significant headroom before reaching the 999-device cap, reducing near-term upsell pressure. Several Standard tier accounts — Meridian Creative Group (42), ClearPath Logistics (60), Stonewall Legal LLP (55) — are approaching the midpoint of their 75-device caps and are candidates for proactive expansion conversations. Basic tier accounts (NovaBridge Health Systems at 18, Pinnacle Biotech at 15) may benefit from an upgrade discussion as their device needs grow.

**Data sources:** `subscriptions.subscription_id`, `subscriptions.customer_id`, `subscriptions.device_count`, `subscriptions.plan_id`, `subscriptions.status`, `service_plans.plan_name`, `service_plans.max_devices`, `service_plans.plan_tier`, `customers.company_name`

---

### 4. Support Ticket Volume, Category & Priority Breakdown

Twenty-two tickets were raised across subscriber accounts during the period. Hardware Fault was the most frequent category (7 tickets, ~39 hours avg resolution). MDM Enrollment tickets (6 tickets) reflect ongoing device onboarding activity. Software Configuration tickets (6 tickets) resolved within 4–11 hours on average. Account & Billing tickets (4 tickets) were the fastest to resolve. Three tickets remain open: a Medium priority MDM Enrollment for Meridian Creative Group (March 10), a Low priority Software Configuration for NovaBridge Health Systems (March 28), and a High priority Hardware Fault for Vertex Software Labs (April 8). The Vertex open ticket requires immediate escalation.

**Data sources:** `support_tickets.ticket_id`, `support_tickets.customer_id`, `support_tickets.opened_date`, `support_tickets.closed_date`, `support_tickets.priority`, `support_tickets.category`, `support_tickets.status`, `support_tickets.resolution_hours`, `customers.company_name`

---

### 5. Agent Performance & Support Workload Distribution

Both agents — Tom Bridges and Aisha Kent — handled broadly equal ticket volumes across the period. Aisha Kent managed a higher proportion of high-priority and hardware fault escalations, reflected in her higher average resolution time. Tom Bridges maintained faster resolution times across Software Configuration and Account & Billing categories. As the managed device fleet continues to grow, a capacity planning review for the support function should be conducted before the next major contract renewal cycle.

**Data sources:** `support_tickets.assigned_agent`, `support_tickets.ticket_id`, `support_tickets.priority`, `support_tickets.category`, `support_tickets.resolution_hours`, `support_tickets.status`, `support_tickets.opened_date`, `support_tickets.closed_date`

---

### 6. Subscription Invoice Collection & Payment Health

Recurring subscription invoices were generated monthly for each active subscriber across all four billing cycles. With the exception of one Outstanding subscription invoice for Stonewall Legal LLP (April billing, due April 15), all subscription invoices were paid within their net-15 terms — a collection rate of approximately 97%. The Stonewall Legal outstanding subscription invoice aligns with the hardware invoice overdue situation at that account, suggesting a broader payment processing issue. A joint account review between finance and account management is recommended.

**Data sources:** `invoices.invoice_id`, `invoices.customer_id`, `invoices.subscription_id`, `invoices.invoice_date`, `invoices.due_date`, `invoices.paid_date`, `invoices.amount`, `invoices.status`, `invoices.invoice_type`, `customers.company_name`

---

## Appendix & Notes

### Assumptions
- MRR is calculated as the sum of monthly_fee values from service_plans joined to active subscriptions.
- Device counts reflect the device_count field on subscriptions, representing contracted coverage, not real-time MDM counts.
- The churned subscription (Halcyon Media Inc) is excluded from active MRR calculations.
- Resolution hours for open tickets are excluded from average resolution time calculations.
- Subscription invoice collection rate covers invoices with invoice_type = 'Subscription' only.

### Known Limitations
- No real-time MDM device inventory table exists; actual enrolled device counts may differ from contracted values.
- No CSAT or NPS data is available to support qualitative account health assessment.
- No multi-year contract term data is captured; renewal risk cannot be assessed by contract expiry date.
- SLA breach thresholds are not defined in the schema; formal SLA compliance cannot be computed.

### Recommended Next Analysis
- Introduce a device inventory table linked to subscriptions for real-time fleet utilisation reporting against plan limits.
- Define and embed SLA targets per ticket priority to enable formal SLA compliance reporting.
- Develop a subscription renewal calendar view to flag accounts approaching renewal windows.
- Conduct an upsell opportunity analysis for Standard tier accounts approaching their max_devices ceiling.
- Initiate a structured win-back assessment for Halcyon Media Inc and evaluate Silver tier churn risk across the portfolio.

---
*Report generated by Corepath Technologies Business Intelligence. For internal use only.*
