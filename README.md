# 🚨 Runway Kill-Switch Analytics System

**Problem:** Startups burn through millions on failing initiatives but don't know when to pull the plug. Most founders wait too long, killing the company.

**Solution:** Built a data-driven kill-switch system that tells founders exactly which initiatives to kill, pause, or scale to maximize runway and survival probability.

---

## 💰 **Key Results**

### Financial Impact
- **$10.16M** - Total 12-month expected loss identified across failing initiatives
- **$131,460** - Monthly cash savings by killing negative ROI initiatives
- **977.5 months** - Runway extension (from 21.5 months to infinite - profitable!)
- **5 initiatives** - Identified for immediate termination (0% profitability probability)

### Decision Intelligence
- **Monte Carlo simulation** - 10,000 iterations to quantify ROI uncertainty
- **Kill-switch thresholds** - Automated kill/pause/scale recommendations
- **Scenario modeling** - Interactive runway impact simulator
- **0% probability** - Statistical certainty that 5 out of 6 initiatives will never be profitable

### Business Insights
- APAC Expansion: **-100% ROI**, $51K/month burn, $0 revenue → Kill = +32.8 months runway
- AI Feature: **-98% ROI**, 0% profit probability → Kill immediately
- Content Marketing: **-85% ROI**, massive waste → Kill
- Mobile App: **-73% ROI**, bleeding cash → Kill
- Enterprise Sales: **-26% ROI** → Pause and reassess
- Core SaaS: **+38% ROI** → ONLY viable product, scale this!

---

## 🛠️ **Technical Stack**

**Database & Analysis:**
- PostgreSQL (financial data warehouse, 5 normalized tables)
- Python (pandas, numpy, scikit-learn, scipy)
- Monte Carlo simulation for ROI uncertainty quantification
- Statistical modeling for profitability probability

**Business Intelligence:**
- Power BI (3-page executive dashboard)
- Excel scenario modeling (interactive what-if analysis)
- DAX measures for KPIs
- Real-time runway projections

**Data Generation:**
- Synthetic startup financial data (18 months, 6 initiatives)
- Realistic burn rates, revenue curves, team structures
- Industry-standard startup economics

---

## 📊 **Dashboard Pages**

### Page 1: Executive Runway Dashboard
![Executive Runway](https://github.com/MohsinR11/Runway-Kill-Switch-Analytics/blob/main/Documentation/Page%201%20Executive%20Runway.png))
- Current runway: 21.5 months (DANGER ZONE)
- 5 critical KPI cards (cash, burn, runway)
- Runway death spiral visualization
- Cash forecast: Act or Die
- Monthly burn waterfall by initiative

### Page 2: Kill-Switch Decision Matrix
![Decision Matrix](https://github.com/MohsinR11/Runway-Kill-Switch-Analytics/blob/main/Documentation/Page%202%20Kill%20Switch%20Matrix.png)
- Initiative performance scorecard
- ROI vs Runway Impact scatter plot
- Kill scenario comparison (runway extensions)
- Data-driven kill/pause/scale recommendations
- Monte Carlo confidence intervals

### Page 3: Scenario Planner
![Scenario Planner](https://github.com/MohsinR11/Runway-Kill-Switch-Analytics/blob/main/Documentation/Page%203%20Scenario%20Planner.png)
- Interactive runway simulator
- 24-month cash projections (4 scenarios)
- Monthly savings calculator
- Implementation roadmap
- Decision framework

---

## 📁 **Project Structure**
```
Runway_KillSwitch_Analytics/
├── data/                          # 11 CSV files
│   ├── monthly_financials.csv
│   ├── initiative_master.csv
│   ├── roi_uncertainty_analysis.csv
│   ├── powerbi_*.csv (6 files)
│   └── ...
├── notebooks/                     # 5 Jupyter notebooks
│   ├── 01_Data_Generation.ipynb
│   ├── 02_Load_to_PostgreSQL.ipynb
│   ├── 03_Excel_Model_Generator.ipynb
│   ├── 04_ROI_Uncertainty_Analysis.ipynb
│   └── 05_PowerBI_Data_Prep.ipynb
├── sql_scripts/
│   └── analysis_queries.sql      # 12 critical SQL queries
├── excel_models/
│   └── Runway_KillSwitch_Scenario_Model.xlsx
├── powerbi/
│   └── Runway_KillSwitch_Analytics.pbix
├── documentation/                 # 16+ visualizations
│   ├── 15_roi_uncertainty_bands.png
│   ├── 16_decision_confidence_matrix.png
│   ├── dashboard_*.png (3 pages)
│   └── ...
└── README.md
```

---

## 🔥 **What Makes This Unique**

**99% of startup analytics projects show:**
- Generic dashboards with vanity metrics
- Historical reporting (what happened)
- Surface-level analysis

**This project delivers:**
- ✅ Prescriptive recommendations (what to DO)
- ✅ Statistical confidence levels (Monte Carlo)
- ✅ Survival-focused decision framework
- ✅ Uncomfortable truths founders need to hear
- ✅ Executive-level strategic thinking

**The uncomfortable conversation:**
> "If you don't kill these 5 initiatives TODAY, you're bankrupt in 21 months. If you kill them, you're profitable and don't need to fundraise. The data shows 0% chance any of them succeeds. This isn't a suggestion—it's survival math."

---

## 💡 **Business Impact**

**For Founders:**
- Know EXACTLY which initiatives are killing the company
- Data-driven permission to make hard decisions
- Quantified runway impact of each decision
- Avoid "sunk cost fallacy" with statistical proof

**For Investors:**
- Portfolio company health monitoring
- Early warning system for burning companies
- Data-driven intervention triggers
- Resource allocation optimization

**For Operators:**
- Initiative-level P&L accountability
- Kill-switch decision framework
- Scenario planning for board meetings
- Cash preservation strategies

---

## 📈 **Key SQL Queries**

- **Initiative Performance Scorecard** - ROI, payback period, recommendation
- **Runway Impact Analysis** - What-if kill scenarios
- **Kill-Switch Decision Matrix** - Automated recommendations
- **Cumulative Burn Analysis** - Historical cash waste by initiative
- **Profitability Forecast** - Current trajectory projections
- **Team Efficiency Analysis** - Revenue per employee
- **Kill Simulation** - Combined impact of multiple kills

---

## 🎯 **Skills Demonstrated**

**Technical:**
- Advanced SQL (CTEs, window functions, scenario modeling)
- Python data science (pandas, numpy, scipy)
- Statistical modeling (Monte Carlo, probability distributions)
- Machine learning concepts (uncertainty quantification)
- Power BI (DAX, data modeling, executive dashboards)
- Excel financial modeling

**Business:**
- Startup economics & unit economics
- Runway management & cash preservation
- Kill-switch decision frameworks
- Scenario planning & what-if analysis
- Executive communication
- Strategic recommendations

**Domain Knowledge:**
- Venture capital & startup financing
- Burn rate optimization
- Initiative-level P&L management
- Founder psychology (making hard decisions)
- Series A-C startup dynamics

---

## 🎤 **Interview Talking Points**

**"I built a runway kill-switch system that:**
- Identified $10M in wasted spend across failing initiatives
- Used Monte Carlo simulation to prove 5 out of 6 initiatives had 0% chance of profitability
- Showed founders how killing these initiatives extends runway from 21 months to infinite (profitable)
- Created an interactive scenario planner showing exact monthly savings from each decision
- This is the conversation most analysts avoid—I lean into it"

**Why this matters:**
- Shows you understand startup survival economics
- Proves you can make uncomfortable recommendations
- Demonstrates executive-level strategic thinking
- Positions you as a decision-maker, not just a reporter

---

## 📧 **Contact**

**[Your Name]**
- LinkedIn: [Your LinkedIn]
- Email: [Your Email]
- GitHub: [This Repository]
- Location: Kanpur, India

---

## 📝 **Data Source**

Synthetic data generated to simulate realistic Series A startup economics:
- 18 months of financial history
- 6 initiatives (product lines, teams, programs)
- Realistic burn rates, revenue curves, team costs
- Based on industry benchmarks and startup patterns

---

## 🚀 **Use Cases**

This framework applies to:
- **Venture-backed startups** (Series A-C, managing burn)
- **Bootstrapped companies** (every dollar matters)
- **Corporate innovation labs** (portfolio of experiments)
- **Product portfolio management** (kill failing products)
- **VC portfolio monitoring** (early warning system)
- **Consulting firms** (turnaround advisory)

---

⭐ **If this saved your company, star this repo!**

💬 **Questions? Open an issue or reach out directly.**

---

*"Most founders kill initiatives 6 months too late. This system tells you 6 months early."*

---

## 📧 Contact

**Mohsin Raza**  
Data Analyst | BI Developer

- 📧 Email: [mohsinansari1799@gmail.com]
- 💼 LinkedIn: [https://www.linkedin.com/in/mohsinraza-data/]
