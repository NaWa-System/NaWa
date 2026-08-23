# Hemköp Detaljhandel AB
## End-of-Period Stock Level Review — Q4 2024
**Organisation:** Hemköp Detaljhandel AB  
**Reporting Period:** As of 28 December 2024  
**Prepared by:** Supply Chain & Inventory Management  
**Date:** January 2025

---

## Executive Summary

This report reviews end-of-period stock levels across the Hemköp store network as of 28 December 2024. Of 16 stock records reviewed, three SKU-store combinations are at or below their reorder threshold, all involving Laxfilé Norsk 400g — a direct result of the Julmat Specialerbjudande promotion running through December 24.

Replenishment orders should be raised immediately for Laxfilé at Hemköp Sundbyberg (18 units, threshold 20), Hemköp Mölndal (11 units, threshold 20), and Hemköp Linnégatan (15 units, threshold 20). Hemköp Nötfärs at Östermalm is above threshold but with a limited buffer and warrants proactive monitoring. The majority of tracked SKUs sit comfortably above their reorder thresholds.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Stock Records Reviewed | 16 | 7 stores, key SKUs, as of 28 Dec 2024 |
| Products at/Below Threshold | 3 combinations | All Laxfilé Norsk; Julmat promotion effect |
| Highest Stock on Hand | Hemköp Ekologiska Tomater – Sundbyberg (195 units) | Well above threshold of 60 |
| Most At-Risk SKU | Laxfilé Norsk 400g | Below threshold at 2 of 3 tracked stores |
| Near-Threshold SKU | Hemköp Nötfärs – Östermalm (38 units, threshold 30) | 8-unit buffer; proactive restock advised |
| Healthy Stock Positions | 11 of 16 records | No immediate action required |

---

## Report Sections

### 1. Stock At or Below Reorder Threshold

Three SKU-store combinations are at or below their reorder threshold as of 28 December 2024. Laxfilé Norsk 400g is below threshold at Hemköp Sundbyberg (18 units vs threshold 20), Hemköp Mölndal (11 units vs threshold 20), and Hemköp Linnégatan (15 units vs threshold 20). This is a direct consequence of the Julmat Specialerbjudande promotion (18% off Meat & Fish, December 9–24). Replenishment should be triggered for all three locations at the start of the first January trading week.

### 2. Near-Threshold Products Requiring Monitoring

Hemköp Nötfärs 500g at Östermalm holds 38 units against a threshold of 30, providing an 8-unit buffer. Given Östermalm's high Professional-segment transaction frequency, proactive restocking is recommended ahead of the regular cycle. Hemköp Nötfärs at Linnégatan (44 units, threshold 35) is also in a tight but manageable position.

### 3. Products with Healthy Stock Levels

Hemköp Ekologiska Tomater (all tracked locations), Hemköp Pasta Penne at Västerås City (134 units, threshold 50), Hemköp Frysta Blandgrönsaker at Mölndal (110 units, threshold 40), and Hemköp Diskmedel Citron at Västerås City (67 units, threshold 25) are all well above their thresholds. No replenishment action is required for these SKUs.

### 4. Replenishment Priority Summary

**Immediate action:** Laxfilé Norsk — Sundbyberg, Mölndal, Linnégatan.  
**Monitor with proactive restock:** Hemköp Nötfärs — Östermalm.  
**No action required:** All remaining 11 SKU-store combinations.

---

## Appendix

### Assumptions
- Stock figures are a snapshot as of 28 December 2024.
- Reorder thresholds are as defined in the stock_levels table.
- Units on hand exclude damaged or quarantined stock.

### Known Limitations
- Only a subset of SKUs and stores are represented.
- No supplier lead time data available in the current schema.
- No inbound delivery schedule data to refine replenishment timelines.

### Recommended Next Analysis
- Add supplier lead time to products or stock_levels for urgency scoring.
- Build a stock velocity metric linking stock_levels to transaction_items sold quantities.
- Move from end-of-period snapshots to weekly stock tracking.
- Model seasonal buffer requirements for high-demand promotional periods.
