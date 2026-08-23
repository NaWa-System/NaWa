# Q1 2026 5G Delivery & Milestone Performance Report

**Organisation:** Nordwave Radio Systems AB  
**Reporting period:** 2026-01-01 to 2026-03-31

## Executive Summary
Across Q1 2026, Nordwave executed a balanced delivery mix of radio hardware, baseband compute, site infrastructure, and integration services across six active customer programs. Two major programs (Skylink Mid-Band Expansion and IberWave Modernization) reached final acceptance within the quarter, while three programs remained in progress with deliveries and milestones staged into Q2.

Operational performance was strongest in the Nordics and Iberia portfolios, where work orders closed on schedule and acceptance milestones were completed with minimal slippage. This was supported by a delivery cadence concentrated in January and February, allowing field integration to progress through March.

The largest near-term risk is concentrated in the DACH capacity upgrade (RheinTel Phase 2), where the “On-Air Wave 1” milestone is marked **At Risk** at quarter-end. While earlier milestones were achieved and invoiced, completion of Wave 1 is dependent on coordinated integration capacity and the finalization of late-quarter antenna shipments.

Service delivery (optimization retainer) ran consistently through month-end sprints, providing predictable operational throughput and creating a stable baseline alongside the more variable hardware and integration activities. Q2 focus should be on converting shipped items to delivered status, closing in-progress integration work orders, and driving at-risk milestones to completion to protect schedule and cash timing.

## Key Metrics
- **Active Projects in Q1:** 6
- **Projects Completed in Q1:** 2
- **Total Deliveries Recorded (Q1):** 20 line-item deliveries
- **Deliveries Shipped but Not Delivered (Q1 end):** 3 line-item deliveries
- **Work Orders Created (Q1):** 13
- **Work Orders Closed (Q1):** 9
- **Milestones Completed (Q1):** 11
- **Milestones At Risk (Q1 end):** 1

## Main Sections
### 1) Program Portfolio Status Overview
The Q1 portfolio combined two completed deployments with three in-progress modernization/trial programs and one ongoing optimization retainer. Completed programs closed with final acceptance dates in mid-to-late March, indicating strong closeout discipline. In-progress programs showed healthy delivery activity, but final on-air readiness is uneven, with the DACH capacity upgrade requiring focused management attention at quarter-end.

### 2) Delivery Execution (Delivered vs Shipped)
Delivery records show the bulk of physical equipment and integration services landed as **Delivered** through January–March, enabling acceptance work to proceed. A small set of late-quarter shipments remained in **Shipped** status at quarter-end, which increases the risk of integration bottlenecks if site readiness or logistics delays extend into Q2. Converting shipped items to delivered and aligning field schedules is a priority to protect milestone timing.

### 3) Milestone Performance and Schedule Health
Milestones across completed programs were achieved near or ahead of due dates, supporting reliable acceptance and invoicing. Most in-progress milestones show forward motion, but the quarter ends with one notable at-risk milestone in the RheinTel portfolio. The at-risk designation suggests that integration and site dependencies should be reviewed, with mitigation actions defined and tracked weekly until the on-air gate is cleared.

### 4) Work Order Throughput (Closed vs In Progress)
Work orders indicate solid operational throughput, with closure concentrated around surveys, staging, and modernization tasks early in the quarter and integration activities continuing into March. Several integration-related work orders remained in progress, consistent with the shipped deliveries and ongoing on-air gates. A targeted closure plan for in-progress work orders should be aligned with milestone due dates to reduce schedule variance.

### 5) Service Delivery Continuity (Optimization Retainer)
The optimization retainer program executed three monthly sprints across January, February, and March, showing consistent cadence and predictable delivery. This service motion provides a stabilizing baseline of activity and supports customer performance outcomes while larger rollout programs move through hardware and acceptance stages. Continuity should be maintained, with potential expansion opportunities identified based on project region performance and post-acceptance optimization needs.

## Appendix / Notes
### Assumptions
- Operational status is inferred from work order status, delivery status, and milestone status as recorded in the database.
- A delivery line item with `delivery_status = 'Shipped'` is treated as not yet available for field acceptance until converted to `Delivered`.
- Project completion is defined by `projects.project_status = 'Completed'` and presence of an `actual_end_date`.

### Known Limitations
- No site-level identifiers are stored; progress cannot be analyzed at individual-site granularity.
- No logistics lead times or risk-reason fields are captured.
- No labor hours or staffing assignments are included.

### Recommended Next Analysis
- Add a site dimension (site_id, city, band, planned on-air date) to quantify deployment velocity.
- Capture milestone dependency flags and risk reasons to enable root-cause reporting.
- Add ship vs delivery lead-time fields to predict schedule impact from logistics variance.
