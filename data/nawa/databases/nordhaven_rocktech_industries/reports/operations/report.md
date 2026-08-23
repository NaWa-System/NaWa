# Q1 2026 Manufacturing Yield, Scrap, and Quality Release Summary

**Organisation:** Nordhaven RockTech Industries  
**Reporting period:** 2026-01-01 to 2026-03-31

## Executive Summary
Manufacturing performance in Q1 2026 was stable across Nordhaven RockTech’s primary plants, with all recorded batches released through quality control and no holds reflected in the dataset. Production volume was concentrated in high-run drilling consumables (45mm and 51mm bits, plus drill rods), while lower-run but higher-cost items (reamers, wear shoe sets) were produced in smaller batch counts.

Scrap levels remained in a manageable range across most batches, with variation by product family that is consistent with process complexity (e.g., carbide tooling and precision components showing higher scrap sensitivity than steel rod production). The quarter’s overall yield supports dependable supply for Q1 shipments and positions the business to serve early Q2 demand assuming continued release cadence.

Unit manufacturing costs show expected stratification by product type, with wear parts materially higher per unit than drilling consumables. While cost stability appears reasonable within Q1, the data highlights opportunities for tighter scrap reduction on selected carbide and adapter runs, which would directly improve cost-to-serve and provide additional buffer against pricing pressure.

Warranty claim reasons recorded during the quarter (including brazing defects and premature wear) provide a useful cross-check for process controls in drill bit production. A structured linkage between claims and production lots would enable faster containment and more targeted corrective actions.

## Key Metrics
- **Batches Completed and Released (Q1):** 10 batches — All Q1-starting batches show `qc_status = 'Released'`.
- **Total Units Produced (Q1):** 6,440 units — Sum of `units_produced` across Q1-starting batches.
- **Total Units Scrapped (Q1):** 144 units — Sum of `units_scrapped` across Q1-starting batches.
- **Overall First-Pass Yield (Q1):** ~97.8% — Calculated from produced and scrapped units.
- **Highest Scrap Rate Batch (Q1):** Batch 302 (Drill Bit 51mm) — Highest scrap percentage in Q1-starting batches.
- **Production Concentration:** Drill consumables dominate volume — Drill bits and drill rods represent most units.
- **Unit Cost Range (Q1 batches):** $94.10 to $538.00 per unit — Observed range in `unit_manufacturing_cost`.
- **Plants with Recorded Production (Q1):** 3 plants — Gothenburg Toolworks, Lulea Steel Cell, Tampere Wear Parts.

## Main Sections
### 1) Quarter Production Overview (Volume and Mix)
Q1 production prioritized core consumables, with high unit volumes in drill bits and drill rods and lower unit counts for reamers, adapters, and wear parts. The mix supports replenishment-driven demand and highlights the importance of protecting quality and yield in high-run SKUs.

### 2) Yield and Scrap Performance
Overall yield for Q1 remained strong, with scrap generally low relative to output. The observed variation suggests targeted improvement opportunities on process-sensitive tooling runs. Sustained scrap reduction would improve unit economics and create capacity headroom.

### 3) Quality Control Release Status
All batches in scope were released by QC, indicating no recorded holds. This should be reviewed alongside field claim signals, as release status alone may not capture latent defects that appear in service.

### 4) Unit Manufacturing Cost by Product Category
Unit costs stratify by product type: wear parts highest, followed by reamers and adapters, then drill bits and drill steel. This reinforces the importance of minimizing scrap on higher-cost items and maintaining price discipline where manufacturing costs are structurally higher.

### 5) Plant-Level Throughput Snapshot
Gothenburg Toolworks carried most precision tooling production, Lulea Steel Cell supported steel and adapter volume, and Tampere Wear Parts produced wear shoe sets. This aligns with specialization; monitoring throughput and scrap by plant can surface localized constraints.

### 6) Field Feedback Signals (Warranty Claims Cross-Check)
Warranty claim reasons include brazing defects and premature wear in drill bit SKUs. Although claim volume is low, the signal is meaningful and supports targeted audits of related processes. Adding lot-level traceability would make this cross-check more actionable.

## Appendix / Notes
**Assumptions**
- Q1 scope includes batches with `start_date` from 2026-01-01 through 2026-03-31.
- Yield computed as (produced - scrapped) / produced.
- Unit cost is sourced from `manufacturing_batches.unit_manufacturing_cost`.

**Known limitations**
- No batch-to-shipment linkage to isolate field issues to specific lots.
- No labor/machine hours or downtime to diagnose capacity.
- QC detail is simplified to a single status without defect codes.

**Recommended next analysis**
- Add batch/lot traceability to shipments to connect claims to production runs.
- Capture cost drivers (materials/labor/overhead) to explain unit cost variation.
- Expand QC defect taxonomy to correlate scrap and warranty outcomes to specific failure modes.
