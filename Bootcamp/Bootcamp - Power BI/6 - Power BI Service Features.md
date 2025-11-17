# Power BI Pro vs PPU: Understanding licensing and features.

| Aspect                  | Power BI Pro              | Power BI Premium Per User (PPU)  |
| ----------------------- | ------------------------- | -------------------------------- |
| Price (USD/month)       | ~$14                      | ~$20–24                          |
| Includes Pro?           | —                         | Yes                              |
| Max Dataset Model       | ~1 GB                     | ~100 GB                          |
| Refreshes per Day       | 8                         | 48                               |
| AI / Advanced Features  | No                        | Yes                              |
| Dataflows / Datamarts   | Basic                     | Enhanced                         |
| XMLA Endpoint           | No                        | Yes                              |
| Deployment Pipelines    | No                        | Yes                              |
| Sharing with Free Users | Only via Premium capacity | Same — only via Premium capacity |
| Admin Management        | Simple                    | No capacity planning needed      |

### Use Cases

- **Go with Pro** if you’re a small team where every user creates and shares reports with other Pro users, and dataset size and refresh requirements are modest.
    
- **Choose PPU** if you’re a smaller to mid-sized organization needing premium features — like large datasets, frequent refreshes, advanced AI, dataflows, and deployment pipelines — and you can manage sharing within users who also have PPU licenses.


---
# Power BI Fabric Free licenses -  Understanding licensing and Microsoft Fabric features.

## Microsoft Fabric Free License: What It Includes

According to Microsoft documentation, there are three _per-user_ license types available:

- **Fabric (Free)**
- **Power BI Pro**
- **Power BI Premium Per User (PPU)**


### **Fabric (Free)**
With the **Fabric (Free)** per-user license, you can:
- **Create and interact with your own content** in Power BI and Fabric—for personal use.
- **Consume content shared by Pro or PPU users** _only_ if it's stored in **Premium capacity** or **Fabric capacity of F64 or higher**.  
    [Microsoft Learn](https://learn.microsoft.com/en-us/power-bi/fundamentals/service-features-license-type?utm_source=chatgpt.com)

Essentially, the Free license allows you to explore and consume content within certain capacity boundaries, but **not to share or collaborate** unless capacity conditions are met.

## Microsoft Fabric Features by License and Capacity

From the Fabric feature parity documentation:

- Some advanced platform features—like the **Fabric data agent**, **ARM/Terraform APIs**, **Copilot**, **managed private endpoints**, **on-demand resizing**, **pause/resume**, and **trusted workspace access**—are only supported on **F (Fabric) SKUs**, not P (Premium) SKUs.  
    [Microsoft Learn](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-features?utm_source=chatgpt.com)
    

Notably:
- **F64 or higher** capacities allow **Fabric Free users** to **view Power BI items**.
- **Lower-tier F SKUs (F2–F32)** require a **Power BI Pro or PPU license** to view Power BI content.  
    [Microsoft Learn](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-features?utm_source=chatgpt.com)[LinkedIn](https://www.linkedin.com/pulse/5-common-myths-fabric-licensing-luk%C3%A1%C5%A1-karlovsk%C3%BD-wgi6f?utm_source=chatgpt.com)

| **Aspect**                                                             | **Fabric Free (per-user)**                  | **Power BI Pro**                             | **Power BI PPU**                         |
| ---------------------------------------------------------------------- | ------------------------------------------- | -------------------------------------------- | ---------------------------------------- |
| Create Fabric artifacts (lakehouse, pipelines, notebooks, etc.)        | **Yes**, if assigned to any Fabric capacity | Yes                                          | Yes                                      |
| Create Power BI reports (shared)                                       | Only in F64+ capacity                       | Yes                                          | Yes                                      |
| View Power BI content in F64+                                          | **Yes** (viewer role)                       | Yes                                          | Yes                                      |
| View Power BI content in lower capacities (e.g., F2–F32, shared)       | No                                          | Yes                                          | Yes                                      |
| Share Fabric or Power BI content                                       | No                                          | Yes – with Pro/PPU or via Premium/F capacity | Yes – with PPU or via Premium/F capacity |
| Advanced Fabric features (Copilot, managed endpoints, autoscale, etc.) | Only via capacity capability (F SKUs)       | Same if capacity supports                    | Same if capacity supports                |
| Trial access to Fabric capacity with full features                     | Available (60-day trial, equivalent to PPU) | Yes (trial)                                  | Yes (trial)                              |
> note 
> Pro and Fabric (Free) Feels same but here is the break down of it

Where Pro **goes beyond Free** is not in storage size, but in **collaboration and sharing**:

- With **Free**, you can only build for yourself (in _My Workspace_) or view content in Premium/Fabric capacity.

- With **Pro**, you can:
    - Share reports/dashboards with other Pro users
    - Publish to app workspaces
    - Collaborate on shared datasets
    - Distribute content through apps

---
# Workspace Roles (Types)

A **workspace** is like a team folder for Power BI content. Each person added to a workspace gets a role that defines what they can do.

|**Role**|**What They Can Do**|
|---|---|
|**Admin**|Full control – add/remove users, change roles, publish, update, delete anything.|
|**Member**|Almost like Admin, but cannot manage workspace access (can publish, edit, delete).|
|**Contributor**|Can add/edit content (reports, dashboards, datasets, dataflows) but **cannot publish/update apps**.|
|**Viewer**|Read-only – can view and interact with reports, dashboards, and datasets but not edit.|
>👉 Tip: Use **Viewers** for consumers, **Contributors/Members** for developers, and **Admins** sparingly.

---
# Deployment Pipelines

Deployment pipelines let you manage **development → test → production** stages for reports and datasets.

- **Stages**: _Dev → Test → Prod_
- Ensures:
    - Developers build safely in Dev
    - QA teams validate in Test
    - End users consume from Prod
- Benefits:
    - Version control
    - Fewer errors
    - Structured governance

>⚠️ Requires **PPU license or Premium capacity**.

### **what is Premium Capacity means**
In **Power BI**, **Premium Capacity** means you (or your organization) are paying for dedicated cloud computing resources instead of using shared ones.
### **Shared vs Dedicated**

- **Free & Pro users** → Run on **shared capacity** (your reports and refreshes share Microsoft’s resources with other tenants).
    
- **Premium Capacity** → Gives your organization **dedicated CPU, memory, and storage**. No resource sharing with other companies, so performance is more predictable and scalable.

### **Key Benefits of Premium Capacity**

- 🚀 **Larger datasets** → Up to **400 GB per dataset** (compared to 1 GB for Free, 10 GB for Pro, 100 GB for PPU).
    
- 🔄 **More refreshes** → Up to **48 times per day** (vs. 8 for Pro).
    
- 📊 **Paginated Reports** → Support for pixel-perfect, paginated reports (like SSRS).
    
- 🧩 **AI & Advanced Features** → Cognitive services, AutoML, advanced dataflows, XMLA endpoint for external tools.
    
- 🌍 **Wider sharing** → You can share dashboards/reports with **free Power BI users in your org** (they don’t need a Pro license if content is hosted in Premium).
    
- ☁️ **Dedicated cloud capacity** → You buy a "capacity SKU" (like P1, P2, P3, etc.) that defines how much RAM/CPU you get.

---
# Apps

An **App** is a packaged collection of dashboards and reports from a workspace.

- Created from a workspace (usually Prod stage).
- Shared with end-users.
- Users get a **read-only view** unless you give them build permission.
- Easier distribution: instead of sharing individual reports, just publish/update the app.

### **How App is different from Workspace**
#### Workspace

- A **collaboration area** for developers/analysts to **build** dashboards, reports, datasets, and dataflows.    
- Think of it as a **backstage** where content is created and managed.
- Multiple people can have roles like **Admin, Member, Contributor, Viewer** inside a workspace.
- Not typically shared with end-users (unless you give them access).

👉 Example: Your BI team is preparing sales reports in a workspace. Everyone with edit rights can work on the same reports before publishing.

#### App

- A **packaged, read-only experience** created from a workspace.
- You **publish** the finalized reports/dashboards from a workspace into an **App**.
- Apps are meant for **business users** → clean, curated, and easier to navigate.
- Users can’t accidentally edit or break things in an app (they only view & interact).
- Apps can include multiple dashboards, reports, and datasets, organized nicely.
    
👉 Example: After your BI team finalizes sales reports in the workspace, you publish them as a **“Sales Insights App”** so management can view them without editing.

---
# Org Apps (Organization Apps)

- **Apps installed org-wide** by Power BI admins.    
- Automatically appear in every user’s Power BI service under _Apps_.
- Useful for:
    - Standard company dashboards (KPIs, financials, HR stats).
    - Training or policy compliance dashboards.
- Managed at the **tenant/admin** level.

---
# Dataflows

Dataflows = **Power Query in the cloud**.
- Used to:
    - Extract, transform, and load (ETL) data centrally.
    - Store cleaned data in Azure Data Lake Gen2.
    - Reuse the same dataset across multiple reports/workspaces.
- Benefits:
    - Centralized data prep (less duplication).
    - Reusable entities (Customer table, Sales table, etc.).
    - Better governance and performance.

⚠️ Advanced dataflows (linked entities, computed entities, incremental refresh) require **PPU or Premium capacity**.

---
# What is Data Refresh?

A **data refresh** is the process of updating your Power BI dataset with the latest data from the source.

- Example: You load a Sales dataset today → tomorrow new sales come in → refresh pulls the new rows into your report.
### **Types of Data Refresh**

1. **On-Demand Refresh**    
    - Triggered manually in Power BI Service (click _Refresh Now_).
    
2. **Scheduled Refresh**
    - Automatically refresh data at specific times.
    - Example: Every day at 7 AM and 7 PM.
    
3. **Live/DirectQuery Refresh**
    - Data is **not imported**; queries run directly against the source (SQL Server, Snowflake, etc.).
    - Always up-to-date (depends on source latency).
        
4. **Incremental Refresh** _(Premium/PPU only)_
    - Only refreshes **new or changed data** instead of reloading the whole dataset.
    - Saves time and resources for large datasets.

|**License**|**Refreshes per Day**|**Dataset Size**|
|---|---|---|
|**Free**|8|1 GB per dataset|
|**Pro**|8|1 GB per dataset|
|**PPU / Premium**|48|Up to 100 GB per dataset|
### **Managing Refresh**

- **Gateway Configuration**
    - Needed if data is **on-premises** (SQL Server, Oracle, files).
    - Installed on a local server/machine to connect Power BI Service with your local data.
        
- **Refresh Failure Alerts**
    - You can enable email notifications if a refresh fails.
        
- **Refresh History**
    - Check dataset settings → _Refresh history_ to see logs of when and why refreshes succeeded/failed.
        
- **Best Practices**
    - Use **incremental refresh** for large datasets.
    - Avoid unnecessary transformations in Power BI (do heavy ETL in SQL/Dataflows).
    - Monitor refresh duration in **Power BI Service metrics**.
    - Keep refresh schedules staggered if multiple datasets hit the same source (to avoid overload).

✅ **In short**:
- **Scheduled refresh** automates updates.
- **Pro & Free** → 8/day, **PPU & Premium** → 48/day.
- **Gateways** connect to on-prem sources.
- **Incremental refresh** = best for big datasets.

---
# What is a Subscription in Power BI?

A **subscription** lets you receive a **snapshot** of a Power BI report or dashboard by email on a schedule.

- You’ll get either:
    - A link to the report/dashboard in the service,
    - Or an **image/PDF attachment** (if allowed).
        
- Useful for executives or business users who want reports delivered without opening Power BI every day.

### **Types of Subscriptions**

- **Self-subscription** → You subscribe for yourself.
- **Group subscription** (Pro/PPU required) → Subscribe **other users** to the same report (you must have rights to share content).

## Requirements & Limits

- **License**:
    - Pro, PPU, or Free (but Free must consume content from Premium/Fabric capacity).
        
- **Dataset refresh dependency**:
    - Subscription emails are sent **after the dataset refresh finishes** (if scheduled).
        
- **Limits**:
    - Max **24 subscriptions per user** per report/dashboard.
    - Attachments only with Pro/PPU + Premium capacity.

---
# What are Usage Metrics?

- Built-in reports in the **Power BI Service** that show **who is using your content, how often, and when**.
    
- Help creators/admins understand:
    - Which reports/dashboards are most popular
    - Who is engaging with the content
    - Whether reports are being used at all (important for governance)

### **What You Can See in Usage Metrics**

Typical insights include:

- **Views over time** (daily/weekly/monthly trends)
- **Unique viewers** (how many distinct users)
- **Most active users** (who’s opening reports most often)
- **Top content** (most viewed reports/dashboards in a workspace)
- **Access method** (web, mobile, embedded)

### **Why It’s Useful**

- **Adoption tracking** → See if reports are actually being used.
- **Performance monitoring** → Spot underused reports that may be retired or redesigned.
- **User engagement** → Identify power users vs casual viewers.
- **Governance** → Ensure sensitive dashboards are only accessed by the right people.

✅ **In short**:  
**Usage Metrics = built-in analytics to monitor report/dashboard adoption.**  
They tell you _who’s using what, how often, and when_ → super useful for measuring ROI and improving your dashboards.