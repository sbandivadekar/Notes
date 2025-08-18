# Snowflake Architecture
### **Traditional Architecture**
1. **Shared Disk Architecture**
	- Here Centralized storage is used.
	- limited scalability.
	- 
2. **Nothing Shared**
	- Here For each node there will be sperate storage.
	- scalable
	- Higher available
	- complex 
	- expensive

> Snowflake uses combination of both traditional architecture called multi-cluster architecture
> Snowflake uses MPP compute clusters.

### **Architecture**

![[Pasted image 20250811113751.png]]

#### **There are 3 Layers**
- **Storage Layer** – Stores all data in a compressed, encrypted format in the cloud (separate from compute). OLAP comes under it.
- **Compute Layer** – Virtual Warehouses process queries via virtual WH; multiple warehouses can work on the same data without conflict.
	- WH = MPP Cluster.
- **Cloud Services Layer** – Coordinates everything: authentication, query parsing, query optimization, metadata, and access control, infrastructure management.

# Edition of snowflake
1. Standard
2. Enterprise
3. Business critical
4. Virtual private 

> [!info] Snowflake Editions
> | Edition | Key Features |
> |---------|--------------|
> | **Standard** | Entry-level plan with core Snowflake features: SQL support, data sharing, Snowsight UI, SnowSQL, federated authentication, Time Travel (1 day), Fail-Safe (7 days), network policies |
> | **Enterprise** | All Standard features **plus**: multi-cluster warehouses, extended Time Travel (up to 90 days), materialized views, search optimization service, masking, tokenization. |
> | **Business Critical** | All Enterprise features **plus**: HIPAA, PCI compliance, enhanced encryption, AWS/Azure PrivateLink support, database failover/failback. Formerly called Enterprise for Sensitive Data (ESD). |
> | **Virtual Private Snowflake (VPS)** | All Business Critical features in a **fully isolated** environment with dedicated metadata and infrastructure for maximum security. Highest security |

---
# Snowflake Pricing

- Compute Cost
	- Data warehouse - used for query processing.
	- Cloud service - usually not charged unless if exceed the WH 10% consumption.
	- server-less - search optimization and snow-pipe.
	- charged for active WH per hour
	- billed by second (minimum of 1 min)
	- depending upon the WH size.
	- TIME | ACTIVE | SIZE
- Storage
	- Monthly storage fees
	- Based on average storage per month.
	- **On demand storage** - pay as you use
	- **Capacity storage** - pay for defined capacity upfront.
- Data transfer cost
	- In **Snowflake**, _data transfer cost_ is the money you pay when data moves **out** of Snowflake to another region, cloud provider, or the public internet.
	- in short if we transfer the data to different region like ASIA -> US then there will be cost involved.

Prices differ as per the region.

---
# Resource Monitoring
- **Purpose:** Track and control **credit usage** (cost) in your Snowflake account.
- **How:** You create a **Resource Monitor** with a **credit quota** and set **triggers** for actions.
- **Actions when thresholds are hit:**
    1. **Notify** (send alert)
    2. **Suspend warehouse(s)**
    3. **Suspend account** (rare, for extreme cases.
**Scope:**

- Can be applied at **account level** (all warehouses) or **specific warehouse** level.
- ❌ **Not** at user level.

**Example:**

- Quota: **100 credits per month**
- Triggers:
    - At 80% → Notify
    - At 100% → Suspend warehouse

📌 **Benefit:** Prevents surprise bills by controlling usage proactively.

---
# Warehouses in Snowflake
#### **Types**
1. **Standard Warehouse -**
	- SIZES - XS -> 4XL
	- most suitable in most use cases
2. **snowpark-Optimizer Warehouse -** 
	- SIZES - M -> 4XL
	- Recommended for memory intensive workload like ML training.
3. **Multi-cluster Warehouse -** 
	- A **multi-cluster warehouse** in Snowflake is a **virtual warehouse** that can automatically start multiple clusters of compute to handle **high concurrency** (many users or queries at the same time).

> **NOTE**
> To create a Warehouse in snowflake one should have A/c admin , Security-Admin or Sys-Admin Role.

#### **Mode of DW**
1. Maximized
	- All clusters in the warehouse **run all the time** (up to the max you set).
	- No scale-down to save cost — everything stays active for **maximum performance**.
	- **Goal:** Handle consistently heavy workloads without delay.
	- Example: MIN=1 and MAX=3 clusters then all 3 clusters will be used.
2. Auto
	- Snowflake **automatically adds or removes clusters** based on query load.
	- If demand increases → more clusters start.
	- If demand decreases → extra clusters shut down.
	- **Goal:** Balance performance and cost.

#### **Scaling Policies**
**Scaling Policy** in Snowflake is another setting for multi-cluster warehouses, and it controls **how aggressively Snowflake decides to add/remove clusters** when queries pile up.

Two Scaling policies are -

| Feature         | Standard                             | Economy                      |
| --------------- | ------------------------------------ | ---------------------------- |
| Scale-up speed  | Fast                                 | Slower                       |
| Query wait time | Low                                  | Can be slightly higher       |
| Cost            | Higher (more clusters active sooner) | Lower (clusters added later) |
| Best for        | Performance priority                 | Cost priority                |
### **Example Scenario**
```
You have a multi-cluster warehouse:
- Min clusters: 1
- Max clusters: 5

If 10 queries suddenly hit at once:
- Standard: Might quickly jump from 1 → 5 clusters to handle them.
- Economy: Might go 1 → 2 → 3 gradually, letting some queries wait.
```

---
# SnowSQL
- used to execute queries from command line.