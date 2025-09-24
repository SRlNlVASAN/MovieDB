use role accountadmin;

use warehouse compute_wh;

use database moviedb;

use schema Stage;

use schema dim;

use schema fact;

--------------------------------------------

create or replace database MovieDB;

create schema Stage;

create schema dim;

create schema fact;

drop schema dataWarehouse;

create or replace stage movieStage;

--------------------------------------------

-- create a stage table
CREATE TABLE moviedb.stage.moviestage(
    name VARCHAR(255),
    rating VARCHAR(10),
    genre VARCHAR(50),
    year INT,
    released VARCHAR(255),
    score FLOAT,
    votes BIGINT,
    director VARCHAR(255),
    writer VARCHAR(255),
    star VARCHAR(255),
    country VARCHAR(50),
    budget BIGINT,
    gross BIGINT,
    company VARCHAR(255),
    runtime INT
);

drop table MovieStage;

-- copy named stage to table
copy into moviedb.stage.moviestage
from @MOVIESTAGE
file_format = (TYPE = 'CSV' , SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY = '"');

-- select stage table
select * from moviedb.stage.MovieStage limit 150; -- 7668 count
--------------------------------------------

-- [dim_movie_name TABLE] --
select count(distinct name) from moviedb.stage.MovieStage; -- 7512 count

-- create table
create or replace table moviedb.dim.dim_movie_name(
m_id int identity(1,1),
name VARCHAR(255));

-- select
select * from moviedb.dim.dim_movie_name limit 200; -- 7512 count

-- insert
insert into moviedb.dim.dim_movie_name (name)
select distinct name from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_genre TABLE] --
select count(distinct genre) from moviedb.stage.MovieStage; -- 19 count

-- create table
create or replace table moviedb.dim.dim_genre(
g_id int identity(1,1),
genre VARCHAR(50));

-- select
select * from moviedb.dim.dim_genre limit 100; --  count

-- insert
insert into moviedb.dim.dim_genre (genre)
select distinct genre from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_director TABLE] --
select count(distinct director) from moviedb.stage.MovieStage; -- 2949 count

-- create table
create or replace table moviedb.dim.dim_director(
d_id int identity(1,1),
director VARCHAR(255)
);

-- select
select * from moviedb.dim.dim_director; -- 2949 count

-- insert
insert into moviedb.dim.dim_director (director)
select distinct director from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_writer TABLE] --

select count(distinct writer) from moviedb.stage.MovieStage; -- 4535 count

-- create table
create or replace table moviedb.dim.dim_writer(
w_id int identity(1,1),
writer VARCHAR(255)
);

-- select
select * from moviedb.dim.dim_writer limit 100; -- 4536 count

-- insert
insert into moviedb.dim.dim_writer (writer)
select distinct writer from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_star TABLE] --

select count(distinct star) from moviedb.stage.MovieStage; -- 2814 count

-- create table
create or replace table moviedb.dim.dim_star(
s_id int identity(1,1),
star VARCHAR(255)
);

-- select
select count(*) from moviedb.dim.dim_star limit 100; -- 2815 count

-- insert
insert into moviedb.dim.dim_star (star)
select distinct star from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_country TABLE] --
select count(distinct country) from moviedb.stage.MovieStage; -- 59 count

-- create table
create or replace table moviedb.dim.dim_country(
p_id int identity(1,1),
country VARCHAR(50)
);

-- select
select * from moviedb.dim.dim_country limit 100; -- 60 count

-- insert
insert into moviedb.dim.dim_country (country)
select distinct country from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_company TABLE] --
select count(distinct company) from moviedb.stage.MovieStage; -- 2385 count

-- create table
create or replace table moviedb.dim.dim_company(
c_id int identity(1,1),
company VARCHAR(255)
);

-- select
select * from moviedb.dim.dim_company limit 3000; -- 2386 count

-- insert
insert into moviedb.dim.dim_company (company)
select distinct company from moviedb.stage.MovieStage;
--------------------------------------------
-- [dim_rating TABLE] --
select count(distinct rating) from moviedb.stage.MovieStage; -- 13 count

-- create table
create or replace table moviedb.dim.dim_rating(
r_id int identity(1,1),
rating VARCHAR(10)
);

-- select
select * from moviedb.dim.dim_rating limit 3000; -- 13 count

-- insert
insert into moviedb.dim.dim_rating (rating)
select distinct rating from moviedb.stage.MovieStage;
--------------------------------------------
select * from moviedb.dim.dim_movie_name limit 100;
select * from moviedb.dim.dim_genre limit 100;
select * from moviedb.dim.dim_director limit 100;
select * from moviedb.dim.dim_writer limit 100;
select * from moviedb.dim.dim_star limit 100;
select * from moviedb.dim.dim_country limit 100;
select * from moviedb.dim.dim_company limit 100;
select * from moviedb.dim.dim_rating limit 100;
--------------------------------------------
-- handling null values in dim tables
SELECT 'Movie Name' AS Dimension, name AS Null_Value FROM moviedb.dim.dim_movie_name WHERE name IS NULL
UNION ALL
SELECT 'Genre' AS Dimension, genre AS Null_Value FROM moviedb.dim.dim_genre WHERE genre IS NULL
UNION ALL
SELECT 'Director' AS Dimension, director AS Null_Value FROM moviedb.dim.dim_director WHERE director IS NULL
UNION ALL
SELECT 'Writer' AS Dimension, writer AS Null_Value FROM moviedb.dim.dim_writer WHERE writer IS NULL
UNION ALL
SELECT 'Star' AS Dimension, star AS Null_Value FROM moviedb.dim.dim_star WHERE star IS NULL
UNION ALL
SELECT 'Country' AS Dimension, country AS Null_Value FROM moviedb.dim.dim_country WHERE country IS NULL
UNION ALL
SELECT 'Company' AS Dimension, company AS Null_Value FROM moviedb.dim.dim_company WHERE company IS NULL
UNION ALL
SELECT 'Rating' AS Dimension, rating AS Null_Value FROM moviedb.dim.dim_rating WHERE rating IS NULL;

-- null row tables

update moviedb.dim.dim_writer set writer = 'unknown' where writer is null;
update moviedb.dim.dim_star set Star = 'unknown' where Star is null;
update moviedb.dim.dim_country set Country = 'unknown' where Country is null;
update moviedb.dim.dim_company set Company = 'unknown' where Company is null;
update moviedb.dim.dim_rating set Rating = 'unknown' where Rating is null;
--------------------------------------------


-- [fct_movies TABLE] --
drop table moviedb.fact.fct_movies;

CREATE TABLE moviedb.fact.fct_movies(
    name INT, --dim
    rating INT, --dim
    genre INT, --dim
    released VARCHAR(255),
    monthInName VARCHAR(20), --formula
    month INT, --case statment
    year INT,
    score FLOAT,
    votes BIGINT,
    director INT, --dim
    writer INT, --dim
    star INT, --dim
    country INT, --dim
    budget BIGINT,
    gross BIGINT,
    company INT, --dim
    runtime INT
);

-- insert data to fact table
insert into moviedb.fact.fct_movies(
name, --dim
rating, --dim
genre, --dim
released, --fact
monthInName, --formula
month, --case statment
year, --fact
score, --fact
votes, --fact
director, --dim
writer, --dim
star, --dim
country, --dim
budget, --fact
gross, --fact
company, --dim
runtime) --fact
select -- select start here --
mn.m_id,
r.r_id,
g.g_id,
ms.released,
LEFT(ms.released, CHARINDEX(' ', released) - 1),
0,
ms.year,
ms.score,
ms.votes,
d.d_id,
w.w_id,
s.s_id,
p.p_id,
ms.budget,
ms.gross,
c.c_id,
ms.runtime
from moviedb.stage.moviestage ms
left join moviedb.dim.dim_movie_name mn on ms.name = mn.name
left join moviedb.dim.dim_rating r on ms.rating = r.rating
left join moviedb.dim.dim_genre g on ms.genre = g.genre
left join moviedb.dim.dim_director d on ms.director = d.director
left join moviedb.dim.dim_writer w on ms.writer = w.writer
left join moviedb.dim.dim_star s on ms.star = s.star
left join moviedb.dim.dim_country p on ms.country = p.country
left join moviedb.dim.dim_company c on ms.company = c.company;



-- select fact
select count(*) from moviedb.fact.fct_movies limit 10; -- stage 7668 / fact 7656 

select * from moviedb.fact.fct_movies limit 1000;

select distinct month, count(name) from moviedb.fact.fct_movies
group by month;



-- update month column in fact table using CASE
UPDATE moviedb.fact.fct_movies
SET month = 
  CASE
    WHEN monthInName = 'January' THEN 1
    WHEN monthInName = 'February' THEN 2
    WHEN monthInName = 'March' THEN 3
    WHEN monthInName = 'April' THEN 4
    WHEN monthInName = 'May' THEN 5
    WHEN monthInName = 'June' THEN 6
    WHEN monthInName = 'July' THEN 7
    WHEN monthInName = 'August' THEN 8
    WHEN monthInName = 'September' THEN 9
    WHEN monthInName = 'October' THEN 10
    WHEN monthInName = 'November' THEN 11
    WHEN monthInName = 'December' THEN 12
    ELSE 0 -- A default value for unmatched months, e.g., 0
  END;

-- handling null in all numeric feilds

select * from moviedb.fact.fct_movies m
left join moviedb.dim.dim_movie_name mn
on m.name = mn.m_id
where runtime is null;

update moviedb.fact.fct_movies set runtime = 110 where name = 13588;

-- fact column name changes --
alter table moviedb.fact.fct_movies rename column name to m_id;
alter table moviedb.fact.fct_movies rename column genre to g_id;
alter table moviedb.fact.fct_movies rename column director to d_id;
alter table moviedb.fact.fct_movies rename column writer to w_id;
alter table moviedb.fact.fct_movies rename column star to s_id;
alter table moviedb.fact.fct_movies rename column country to p_id;
alter table moviedb.fact.fct_movies rename column company to c_id;
alter table moviedb.fact.fct_movies rename column rating to r_id;

-- added new column
select * from moviedb.dim.dim_rating;

update moviedb.dim.dim_rating
set fullForm = 'TV - No Children Under 14'
where rating = 'TV-14';

select * from moviedb.information_schema.tables;

--database structure --

database - moviedb

schema - information_schema

schema - stage
table - moviestage
stage - MOVIESTAGE

schema - dim
table - DIM_COMPANY
table - DIM_GENRE
table - DIM_MOVIE_NAME
table - DIM_DIRECTOR
table - DIM_STAR
table - DIM_WRITER
table - DIM_RATING
table - DIM_COUNTRY

schema - fact
table - FCT_MOVIES