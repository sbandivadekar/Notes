**theme:** 🎬 _Bollywood Analytics Dashboard (Box Office + Production Insights)_  
**Audience:** Analysts, Producers, and Studio Executives  
**Goal:** Interactive exploration of movie performance, profitability, and trends using Sigma’s advanced modeling & interactivity.

# 🧭 PAGE STRUCTURE OVERVIEW

|Page|Focus|Highlights|
|---|---|---|
|**Page 1: Overview Dashboard**|High-level KPIs and trends|Dynamic KPIs, sparklines, controls, conditional formatting|
|**Page 2: Movie Analysis**|LOD metrics, benchmarks, and dynamic charts|Benchmark chart, actor/director comparison|
|**Page 3: Production Insights**|Cost, runtime, profitability|Pivot with conditional formatting, drill-down|
|**Page 4: User Inputs & What-If**|Forms + empty table + writeback|User input for predictions or feedback|
|**Page 5: Data & Report Download**|Materialized dataset view|Download buttons and export options|

## 🧩 PAGE 1 – **Overview Dashboard**

### 🎯 Purpose

High-level metrics of movie performance and profitability.

|Section|Component|Description|
|---|---|---|
|**Top Row**|**KPI Cards**|💰Total Revenue, 🎞️Total Movies, 🎬Avg Opening, 📈Profit Margin%, 🔥Top Genre|
||Use Sigma formula example: `[movie_total_worldwide] / [movie_opening]` for Growth Ratio||
|**KPI Enhancements**|- Add **Sparkline** for trend by year (`[movie_total_worldwide]` over `[release_year]`) - Conditional formatting (green = positive, red = below avg)||
|**Middle Section (Left)**|**Benchmark Chart**|Compare movie performance vs average industry benchmark (e.g. Movie Gross vs Avg Genre Gross) `IF([movie_total] > AVG([movie_total]), "Above Benchmark", "Below Benchmark")`|
|**Middle Section (Right)**|**Dynamic Bar/Line Chart**|Toggle between _Revenue / Profit / Cost_ using a **Parameter Control**|
|**Bottom Section**|**Interactive Map or Bar by Region**|Filterable by `release_year` and `movie_genre`|
|**Dynamic Text Header**|Example formula: `"Showing results for " + [Selected Genre] + " movies released in " + [Selected Year]`||

## 🧮 PAGE 2 – **Movie Analysis (LOD & Benchmarks)**

### 🎯 Purpose

Drill-down on detailed performance using **LOD (Level of Detail)** and benchmark metrics.

|Section|Component|Description|
|---|---|---|
|**Top Controls**|Genre, Year, Director, Actor|Multi-select input controls for filtering|
|**Left**|**Table (LOD Metric)**|Metric: _Movie Total per Director regardless of filters_ Formula: `Sum([movie_total]) FIXED [movie_director]`|
|**Center**|**Benchmark Chart (Box Plot or Bar)**|Compare each director’s average total vs global avg (industry benchmark)|
|**Right**|**Dynamic Chart Selector**|Dropdown → “Revenue Trend / Director Comparison / Actor ROI” Changes chart dynamically using parameters|
|**Bottom**|**KPI with Target Bar**|Show “Movies Above Benchmark” count using Sigma function: `CountIf([movie_total] > [Benchmark_Value])`|

## 🧮 PAGE 3 – **Production Insights (Pivot + Conditional Formatting)**

### 🎯 Purpose

Operational insights (runtime, cost, profitability) with pivot and formatting.

|Section|Component|Description|
|---|---|---|
|**Top Filters**|Year, Producer, Banner, Genre|Dropdowns linked to charts|
|**Left**|**Pivot Table**|Rows = Producer, Columns = Year, Values = Avg Runtime / Total Cost Conditional formatting: highlight above-average cost|
|**Center**|**Scatterplot**|X = Runtime, Y = Box Office Total, Size = Profit Margin|
|**Right**|**Bar Chart (Profitability by Banner)**|Add Benchmark Line (`AVG([Gross Profit])`)|
|**Bottom**|**Dynamic KPI Cards**|“Top 5 Producers by Profit” using `RANKDENSE([Gross Profit], [Producer])`|

## 📝 PAGE 4 – **User Inputs & Forms**

### 🎯 Purpose

Collect user data or simulate what-if scenarios.

| Section    | Component                             | Description                                                                                          |
| ---------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| **Left**   | **Form (Writeback)**                  | Fields: Movie Name, Estimated Opening, Estimated Total, Predicted Genre                              |
| **Center** | **Empty Table (Dynamic Placeholder)** | Shows data only when filters or form inputs exist Formula: `IF([Selected Movie], [movie_name], "")`  |
| **Right**  | **Comparison Card**                   | Compare user input movie vs actual dataset average                                                   |
| **Bottom** | **Dynamic Text Feedback**             | Example: `IF([Predicted Total] > AVG([movie_total]), "Expected Blockbuster!", "Moderate Performer")` |

## 📦 PAGE 5 – **Data & Report Download**

### 🎯 Purpose

Materialized dataset view and report exports.

| Section            | Component                                                                      | Description                                                                                                   |
| ------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| **Top Section**    | **Materialized Dataset Table**                                                 | Create a _Materialization Table_ of merged facts and dims using Sigma’s **Create Dataset → Materialize Data** |
| **Middle Section** | **Filters + Summary Metrics**                                                  | Summary cards update dynamically                                                                              |
| **Bottom Section** | **Report Download Button**                                                     | Add “📥 Export as PDF / CSV” button (Sigma built-in Action)                                                   |
| **Notes Section**  | Include Timestamp using `Now()` function and user info from control            |                                                                                                               |
| **Footer**         | “Report generated on {{CurrentDateTime}} for {{SelectedGenre}}” (Dynamic text) |                                                                                                               |