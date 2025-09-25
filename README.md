# MovieDB

Build a Cinephile's Dream Database by extracting and loading movie data into a Data Warehouse (DW) with a star schema design and advanced SQL queries for efficient analysis.

---

### Dataset Overview

This dataset includes **6,820 movies from 1980 to 2020** and is designed to analyze key trends in the movie industry. The dataset helps answer questions such as:

- How has movie revenue changed over time?
- How do factors like budget, user ratings, and runtime affect movie success?
- What is the relationship between actors, directors, and a film's gross revenue?

---

### Dataset Attributes

Each movie entry contains the following fields:

- **name**: Movie title
- **genre**: Main genre
- **year**: Release year
- **released**: Full release date
- **rating**: Movie rating (e.g., R, PG)
- **runtime**: Duration in minutes
- **score**: IMDb user rating
- **votes**: Number of user votes
- **director**: Director name
- **writer**: Writer name
- **star**: Main actor/actress
- **company**: Production company
- **country**: Country of origin
- **budget**: Movie budget (0 if unavailable)
- **gross**: Total revenue

---

### Dataset Years Covered

| 1980 | 1988 | 1996 | 2004 | 2012 |  
| 1981 | 1989 | 1997 | 2005 | 2013 |  
| 1982 | 1990 | 1998 | 2006 | 2014 |  
| 1983 | 1991 | 1999 | 2007 | 2015 |  
| 1984 | 1992 | 2000 | 2008 | 2016 |  
| 1985 | 1993 | 2001 | 2009 | 2018 |  
| 1986 | 1994 | 2002 | 2010 | 2019 |  
| 1987 | 1995 | 2003 | 2011 | 2020 |  

---

### What is Data Modeling?

Data modeling splits OLTP data into dimension (dim) and fact tables organized in star or snowflake schemas. Following normalization guidelines helps maintain and scale large volumes of data efficiently.

**Skill highlights:** Dimensional modeling, data warehouse design, snowflake schema, advanced SQL.

---

### Dataset Flow & Process

1. Start with a star schema approach to separate schemas for stages, dimension tables, and fact tables.
2. Use Snowflake's internal features to insert data from CSV files into a named stage.
3. Use the COPY command to populate a staging table (source of truth) from internal stage CSV data.
4. Denormalize staging data into a single fact table and multiple dimension tables based on star or snowflake schema.
5. Transform and clean fact table data to handle null values and make it OLAP-friendly.
6. Create a database plan for all data objects as part of the modeling project.
7. Use Snowflake notebooks to analyze the database using aggregation and window functions in SQL.

---

### Database Structure

- **Database:** moviedb  
- **Schemas and Tables:**  

| Schema              | Tables / Stages                                  |
|---------------------|-------------------------------------------------|
| information_schema  | (system metadata)                                |
| stage               | moviestage (table), MOVIESTAGE (stage)         |
| dim                 | DIM_COMPANY, DIM_GENRE, DIM_MOVIE_NAME, DIM_DIRECTOR, DIM_STAR, DIM_WRITER, DIM_RATING, DIM_COUNTRY |
| fact                | FCT_MOVIES                                       |

---

### Included Files in Git Repository

- `MovieDB DDL.sql` — Main database script  
- Project screenshots folder  
- Database backup file  
- `Analysis_Result` folder containing 2 MovieDB notebooks (`.ipynb`): one with outputs, one with code only  

---

### Project Screenshots Reference

1. Database overview  
2. Dimension tables  
3. Fact tables  
4. Stage tables  
5. Table definition code snippets  
6. SQL analysis notebooks 1 and 2  
7. SQL analysis notebooks 3 and 4  
8. SQL analysis notebook 5  

---

### Next Steps

Use the attached code and notebooks to import the project into your environment and run analysis queries yourself for hands-on learning.
