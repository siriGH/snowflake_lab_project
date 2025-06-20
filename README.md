# snowflake_lab_project
Snowflake hands-on project with data loading, S3 external stage, and transformations
# Snowflake Data Engineering Lab Project

Welcome to my personal Snowflake lab project! This repository reflects the practical exercises I completed as part of my ongoing journey to become a better data engineer. My goal was to go beyond theory and get hands-on experience with real SQL tasks, cloud integration, and Snowflake capabilities.

This project showcases how I loaded data from AWS S3 into Snowflake, explored external stages, and performed basic to intermediate-level data transformations — all through SQL. Each piece of work here helped me understand not only *how* Snowflake works, but also *why* certain practices matter in real-world data engineering.

## What I Worked On

### Data Loading (`data_loading.sql`)

* Created a database (`MYDB`) and a basic table (`LOAN_PAYMENT`)
* Loaded a CSV file stored in an S3 bucket into Snowflake using `COPY INTO`
* Verified data load with `SELECT` queries and row counts

### External Stage & Transformations (`data_transformation.sql`)

* Set up an **external schema** and defined a **stage** pointing to an S3 bucket
* Listed and previewed raw data files directly from the stage using `$`-based references
* Performed data aliasing for better readability
* Loaded transformed data into new Snowflake tables
* Used **SQL functions** like `substring`, `concat`, and `CASE WHEN` during ingestion
* Experimented with **sequences** and **auto-increment** for surrogate key generation

## Screenshots

You can find screenshots of the results and data previews in the `/screenshots/` folder. These were taken directly from my Snowflake worksheets.

## Tools I Used

* **Snowflake** (cloud data platform)
* **SQL** (Snowflake’s dialect)
* **AWS S3** (cloud storage for staging files)

## What I Learned

* How external stages work in Snowflake
* How to load, preview, and transform data during ingestion
* Best practices around schema design and surrogate keys
* Writing SQL with a transformation mindset, not just querying
* Creating an external stage isn’t just about functionality — it’s about building with purpose:
  1. Reusing S3 paths across loads
  2. Previewing files before ingesting
  3. Securing access through integrations
  4. Keeping workflows clean and maintainable

---

## About Me

**Sirisha Karusala**
I’m passionate about cloud data technologies and always eager to expand my skills through hands-on learning. This project was a fun and educational exercise, and I’m excited to share it with fellow learners and professionals.

Feel free to connect with me on www.linkedin.com/in/sirishakarusala
