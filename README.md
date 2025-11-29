 Staffing & Revenue Analytics — SQL + Python Take‑Home
This project is a timed SQL + Python take‑home that analyzes skilled nursing facility staffing and revenue using CMS facility data, PBJ staffing hours, and synthetic shift‑level revenue plus sales‑rep attribution.[web:1] All work is implemented in a single Jupyter notebook: `Yoga_Sundara_SQL_TakeHome.ipynb`.[web:1]

 Notebook contents

- **Question 1 – Top 10 chains by PBJ hours:** SQL query using CTEs and joins between `facilities` and `pbj_hours` to aggregate RN/LPN/CNA hours by chain, count facilities with PBJ activity, and compute each chain’s share of statewide staffing hours.[web:1]  
- **Question 2 – Admin contacts for top 100 facilities:** Python + SQL workflow that selects the top 100 facilities by PBJ hours, cleans facility and admin text fields, and matches administrator name and email from `admin_details`, achieving 94% coverage.[web:1]  
- **Question 3 – Deal revenue & commissions:** SQL that derives a 30‑day revenue window from the first shift date per deal, sums revenue as \((\text{charge\_rate} - \text{pay\_rate}) \times \text{hours}\), and allocates commissions to reps based on stored split percentages.[web:1]  

Extra credit work

- **Interactive facility map:** Plotly Mapbox visualization of all facilities with marker size and color driven by total PBJ hours, with hover details for facility name, city/ZIP, and total hours.[web:1]  
- **Adult Care Home scraper:** Python script that locates the Adult Care Home XLSX link on the NC DHHS site, downloads it, loads it into pandas, and previews the first 10 rows.[web:1]

Skills demonstrated

- Advanced SQL: CTEs, grouped aggregation, percentage‑of‑total logic, multi‑table joins, and window‑style reasoning with grouped dates.[web:1]  
- Python for analytics: text and ZIP normalization, heuristic record linkage, web requests, HTML parsing with BeautifulSoup, and working with SQLite from pandas.[web:1]  
- Data visualization: geospatial mapping with Plotly Mapbox and informative hover tooltips.[web:1]
