## 1. Concept: Fact Tables + Shared Dimensions

- **Fact Tables:** Store measurable, transactional, or aggregated data.  
    Example for your video game dataset:
    
    1. `FACT_SALES` → game sales metrics (`total_sales`, `na_sales`, `jp_sales`, etc.)
        
    2. `FACT_CRITIC_SCORE` → critic and user review metrics (`critic_score`, `review_count`, etc.)

- **Dimension Tables:** Store descriptive/contextual attributes.  
    Example:
    
    - `DIM_GAME` → `title`, `console`, `genre`
        
    - `DIM_PUBLISHER` → `publisher`, `publisher_country`
        
    - `DIM_DEVELOPER` → `developer`, `developer_country`
        
    - `DIM_DATE` → `release_date`, `year`, `month`, `quarter`
        
- **Shared Dimensions:** Both fact tables can connect to the same dimensions. For example:
    
    - `FACT_SALES` joins `DIM_GAME`, `DIM_PUBLISHER`, `DIM_DATE`
        
    - `FACT_CRITIC_SCORE` joins `DIM_GAME`, `DIM_DEVELOPER`, `DIM_DATE`

This allows you to **analyze different metrics together** while maintaining a clean star schema design.

## 2. Schema Visualization

![[Pasted image 20251009103556.png | 400]]

## 3. Benefits

- **Separation of concerns:** Keep sales metrics separate from review metrics.
    
- **Flexibility:** You can add more fact tables later (e.g., `FACT_USER_ENGAGEMENT`).
    
- **Advanced analytics:** Easily create dashboards comparing metrics across fact tables using shared dimensions.
    
- **Optimized performance:** Smaller, focused fact tables are often faster for queries.

## 4. Implementation Tips in Sigma

1. **Create Dimension Tables First** → load `DIM_GAME`, `DIM_PUBLISHER`, `DIM_DEVELOPER`, `DIM_DATE`.
    
2. **Create Fact Tables** → load `FACT_SALES` and `FACT_CRITIC_SCORE` referencing the dimensions via **keys**.
    
3. **Use Lookups / Joins in Sigma** → when building visuals:
    
    - Sigma lets you create **joins between tables** in the “Data” panel.
        
    - Join `FACT_SALES` → `DIM_GAME` via `game_id`, `FACT_CRITIC_SCORE` → `DIM_GAME` via `game_id`.
        
4. **Optional:** Use **calculated fields** to combine metrics from both fact tables for advanced KPIs.

-- FACT_SALES
CREATE OR REPLACE TABLE FACT_SALES (
    GAME_ID STRING,
    DATE_KEY DATE,
    PUBLISHER_ID STRING,
    TOTAL_SALES FLOAT,
    NA_SALES FLOAT,
    JP_SALES FLOAT,
    PAL_SALES FLOAT,
    OTHER_SALES FLOAT
);

-- FACT_CRITIC_SCORE
CREATE OR REPLACE TABLE FACT_CRITIC_SCORE (
    GAME_ID STRING,
    DATE_KEY DATE,
    DEVELOPER_ID STRING,
    CRITIC_SCORE FLOAT,
    REVIEW_COUNT INT
);

-- DIM_GAME
CREATE OR REPLACE TABLE DIM_GAME (
    GAME_ID STRING PRIMARY KEY,
    TITLE STRING,
    GENRE STRING,
    CONSOLE STRING
);
