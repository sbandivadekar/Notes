- [x] Dataset
- [x] Snowflake schema
- [x] data modeling
- [x] Metrics
- [x] Modal
- [x] calculated columns
- [x] Pop over
- [x] Parameters
- [x] Conditional Formatting
- [x] Bench mark
- [x] navigation
- [x] interactive visuals
- [x] Tools tips
- [x] RLS
- [x] Sigma specific functions
- [x] **LOD**
- [x] CLS
- [x] Exporting result as PDF, csv
- [x] Documentation
- [x] WOW
- [x] Version Tags
- [x] Materialization

---

# mandatory topics

- [ ] RLS - teams A&B
- [x] CLS - teams A&B
- [x] LOD
- [x] calculated columns
- [ ] Sigma functions
- [ ] Users
- [x] Version tags
- [x] 2 star schema
- [ ] 2 WOW


---

# :compass: Sigma BI Certification Checklist

## 1️⃣ Data Foundation & Modeling
**Goal:** Structure and prepare data correctly.

- [ ] Connect live to Snowflake (no extracts)
- [ ] Build a Dataset from Snowflake tables
  - [ ] Perform Joins, Lookups, and Unions where needed
  - [ ] Add Calculated Columns (row-level logic)
- [ ] Create a Data Model
  - [ ] Define Relationships between datasets/tables
  - [ ] Add Metrics (e.g., Revenue, Profit Margin, Incident Rate, etc.)
  - [ ] Add Summaries and Aggregations
  - [ ] Use Naming conventions and organize fields properly
- [ ] Document dataset lineage (using Sigma description fields)

---

## 2️⃣ Data Transformation & Logic
**Goal:** Demonstrate intermediate+ formula & transformation skills.

- [ ] Use Conditional logic (IF, CASE, AND/OR) for derived fields
- [ ] Implement Aggregations (SUM, AVG, COUNTDISTINCT)
- [ ] Use Join(), Lookup(), or Find() functions where applicable
- [ ] Apply Parent–Child relationships in grouping or hierarchy data
- [ ] Demonstrate Scenario calculations (e.g., “What if 10% sales growth?”)

---

## 3️⃣ Input & Interactivity
**Goal:** Highlight user-driven exploration and advanced workbook design.

- [ ] Add Control Elements
  - [ ] Dropdowns
  - [ ] Sliders
  - [ ] Date pickers
  - [ ] Checkboxes
  - [ ] Number inputs
- [ ] Implement Synced Controls across visuals or pages
- [ ] Add Dynamic Filtering using parameters or control-linked formulas
- [ ] Use Parameters in Workbooks for custom calculations or targets
- [ ] Create Input Tables
  - [ ] Linked Input Table (CRUD operations)
  - [ ] Scenario input (user-entered data that changes calculations)
- [ ] (Optional) Build a Data App-style form for user input

---

## 4️⃣ Visual Design & Storytelling
**Goal:** Showcase BI storytelling & layout best practices.

- [ ] Create Multiple Visuals
  - [ ] Tables
  - [ ] Bar/Line charts
  - [ ] Pie/Donut charts
  - [ ] KPI cards
  - [ ] Combo charts (Bar + Line)
  - [ ] Custom visuals (via Plugin Gallery)
- [ ] Use Conditional Formatting for highlighting
- [ ] Build Multi-Element Dashboard layout
- [ ] Use Linked Interactivity (click/filter across visuals)
- [ ] Include Page Navigation (buttons, tabs)
- [ ] Add Dynamic Titles or Text using formulas (e.g., selected filter context)

---

## 5️⃣ Security, Governance & Publishing
**Goal:** Demonstrate enterprise-readiness.

- [ ] Implement Row-Level Security (RLS) using User() or role-based logic
- [ ] (Optional) Add Column-Level Security (CLS) if relevant
- [ ] Set permissions for viewers/editors appropriately
- [ ] Publish dashboard to workspace with clear name & metadata
- [ ] Set up Refresh schedules / materialization if using heavy queries

---

## 6️⃣ Optimization & Performance
**Goal:** Test understanding of Sigma–Snowflake relationship.

- [ ] Use Preview vs Executed Mode consciously
- [ ] Materialize intermediate steps when performance lags
- [ ] Summarize large datasets before visual use
- [ ] Avoid excessive per-row formulas at visual level
- [ ] Verify query pushdown to Snowflake via query logs

---

## 7️⃣ Presentation & Documentation
**Goal:** Be demo-ready & certification-ready.

- [ ] Include Dashboard Summary / Overview text box
- [ ] Clearly label visuals and add tooltips
- [ ] Explain key metrics and logic in notes section
