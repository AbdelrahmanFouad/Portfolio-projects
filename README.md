# Data Analysis Portfolio — SQL & Python

A collection of data analysis projects covering web scraping, API integration, SQL data cleaning, and exploratory data analysis (EDA).

## 📂 Projects

### 🐍 Python

#### Amazon Web Scraper
- **File:** `Amazon web scraper.ipynb`
- Scrapes Amazon product listings (title, price, rating, reviews) using BeautifulSoup
- Tracks price changes over time by re-running the scraper and logging results to CSV
- Built-in email alert when price drops below a target threshold

#### Crypto API Data Pipeline  
- **File:** `Crypto api.ipynb`
- Pulls live cryptocurrency data from the CoinMarketCap API
- Normalizes JSON response into a structured DataFrame
- Visualizes price trends across multiple coins using Matplotlib/Seaborn

---

### 🗄️ SQL (MySQL)

#### Nashville Housing — Data Cleaning
- **File:** `Nashville housing data cleaning.sql`
- Standardizes date formats, populates null property addresses via self-join
- Splits address into individual columns (Address, City, State)
- Removes duplicates using ROW_NUMBER() CTEs, drops unused columns

#### World Layoffs — Data Cleaning
- **File:** `World layoffs data cleaning MySQL project.sql`  
- Full ETL cleaning pipeline on a global tech layoffs dataset
- Handles staging tables, duplicate removal, null handling, and column normalization

#### World Layoffs — Exploratory Data Analysis
- **File:** `World layoffs exploratory data analysis (EDA) project.sql`
- Analyzes layoff trends by company, industry, country, and funding stage
- Rolling total layoffs by month using window functions
- Top companies by layoffs per year using DENSE_RANK()

#### COVID Data Exploration
- **File:** `Covid data exploration sql project.sql`
- Joins COVID deaths and vaccination datasets
- Calculates death percentages, infection rates, vaccination rollout by country
- Creates views for downstream visualization

---

## 🛠️ Skills Demonstrated

| Skill | Tools |
|-------|-------|
| Web Scraping | BeautifulSoup, Requests |
| API Integration | CoinMarketCap API, Pandas |
| Data Cleaning | MySQL, CTEs, Window Functions |
| EDA | Pandas, Matplotlib, Seaborn |
| Automation | Python scheduled tasks |

## 💡 Future Ideas

- [ ] Power BI dashboard on top of the SQL datasets
- [ ] Streamlit app for interactive EDA on uploaded CSVs
- [ ] Add a music industry revenue analysis project (Spotify/YouTube)

---

> Part of a broader data operations practice — combining SQL and Python to turn raw data into actionable insights.
