# Data modeling
- Omni uses `Just in time (JIT)` data model, where you can build and expand model as you go ahead with analysis. instead of building the whole model at once.
- “Just-in-Time” borrows the analogy of a JIT compiler in software: only process what you need when you need it.

# How it works (architecture)

The article describes a _layered architecture_ to support this workflow, consisting of four layers: [omni.co](https://omni.co/blog/just-in-time-data-modeling)

1. Raw database layer (the unmodeled ingest)
2. In-database data model layer (for example using tools like dbt)
3. Governed data model layer (trusted, reusable metrics/dimensions)
4. Ad-hoc workbook/analysis layer (where you experiment, iterate fast)

---
# This layering allows:

- **Flexibility:** people can use point-&-click UIs, spreadsheets, SQL, even AI, to do rapid analysis in the ad-hoc layer.

- **Promotion path:** when ad-hoc work proves valuable, it can be “promoted” into the governed model for reuse.

- **Balance between speed and trust:** you don’t have to wait until everything is perfect, but you still maintain a path to build a reliable model.

---
# When modelling first _makes sense_

The author also acknowledges that JIT modelling is **not always** the right approach. Some cases where the model-first approach still makes sense:

- When your data set _is_ the product (so you need very rigorous modelling from the start). [omni.co](https://omni.co/blog/just-in-time-data-modeling)
    
- When data is massive and needs pre-aggregation / optimization before analysis. [omni.co](https://omni.co/blog/just-in-time-data-modeling)
    

So the point isn’t to discard rigorous modelling entirely, but to choose modelling timing (just-in-time vs up-front) depending on the situation.

---
# architecture

### **1️⃣ Raw Data Layer**

- Your **source tables** and unmodeled datasets stored in the warehouse.
    
- Omni reads these directly (no data movement).
    
- Analysts can query them instantly.  
    💡 _Analogy:_ This is your “raw ingredients” layer.

### **2️⃣ Transformation / In-Database Model Layer**

- Modeled using SQL transformations (often built in dbt or directly in Omni).
- Cleans, joins, and standardizes raw data.
- Acts as the foundation for consistent analysis.  
    💡 _Think:_ Your “clean kitchen prep” before cooking insights.

### **3️⃣ Governed Data Model Layer**

- The **semantic layer** — reusable metrics, dimensions, and relationships are defined here.
- This is where **JIT modeling** comes in:
    - Analysts can promote metrics (like _average delivery time_ or _on-time %_) into this layer _just in time_ when they prove useful.
- Ensures organization-wide metric consistency.  
    💡 _Analogy:_ Your “recipe book” of trusted definitions.

### **4️⃣ Ad-hoc / Workbook Layer**

- The **exploration layer** for analysts.
- You can write SQL, drag-and-drop visualizations, apply filters, and run quick tests.
- No need to wait for formal modeling — Omni lets you explore data immediately.  
    💡 _Think:_ Your “test kitchen” — fast, flexible, and creative.


---
# Access filters
A **Filter** is used for **exploration or slicing** — it’s _temporary_ and _user-controlled_.
It does **not change user permissions** — it only changes what’s shown in the chart or dashboard.

access_filters:
	-field: product_view.brand
	user_attribute: brand
	values_for_unfiltered: [ is_admin ]

meaning if the attribute value is is_admin then then all the data will be visible.


![[Pasted image 20251113122411.png]]

---
# access grant
An **Access Grant** defines **permanent, enforced access rules** — usually based on user attributes (like region, department, or role).

It ensures that even if a user removes all filters, they **can never see restricted data**.
access_grant:
	-field: product_view.brand
	user_attribute: brand
	allowed_values: [ levi's ] 

|Feature|Purpose|Affects|
|---|---|---|
|**Access Grants**|Control **who can see which rows of data**|Data-level security (row-level access)|
|**Filters**|Control **which data is currently displayed** in a visualization or workbook|Analysis view (temporary or user-driven)|

---
# How dbt and BI should work together: Omni’s dbt integration

### ☕ **What this Omni + dbt article is saying (in easy words)**

- **dbt** is a tool that cleans and prepares your data (it’s used by data engineers).
    
- **Omni** is a BI tool that shows that data in dashboards and reports (used by analysts).
    

Usually, these two don’t talk smoothly — when engineers change something in dbt, dashboards can break.

So Omni made an **integration** that makes them work **together perfectly**.

---

### 💡 What this integration does

1. 🧱 **Dev & Prod environments**  
    You can test new dbt changes safely in _dev mode_ before showing them live in dashboards. No more breaking charts!
    
2. 🔄 **Auto-update when dbt changes**  
    If someone changes a column or model name in dbt, Omni can refresh and fix those links automatically.
    
3. 🚀 **Sync both ways**  
    Analysts can create logic in Omni and push it back to dbt.  
    So both sides (engineering + analytics) stay in sync — no double work.
    

---

### 🎯 **Why it’s good**

- Dashboards don’t break when dbt updates.
    
- Engineers and analysts can work faster together.
    
- Everyone sees the same, trusted data.

---
# Omni’s dbt IDE

Omni has built a new **dbt IDE** inside their platform so that data teams can create and edit dbt models _directly from_ Omni — instead of switching back and forth between tools. This helps speed up the workflow and keeps BI (dashboards, reports) and data models in sync.

## 🔧 What you _can_ do with this feature

- Browse dbt models & metadata **inside Omni** — you don’t need to leave the BI tool to understand how a field is defined in dbt. [omni.co](https://omni.co/blog/creating-and-editing-dbt-models-with-omnis-dbt-ide?utm_source=chatgpt.com)
    
- Create a **new dbt model** or **edit an existing one** via Omni’s IDE: write SQL (with dbt’s `ref()` and `jinja` support), run it, validate changes, and push your code back into your dbt project (with pull request / branching via GitHub).

### 🧠 In short

> Omni’s new dbt IDE = “Analyse & model in the same place”  
> You can see how things are defined, change them, test them, and deploy them — all without leaving the BI tool.  
> Outcome: faster, safer, more unified workflow between model building and dashboard building.

---
