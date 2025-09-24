-- BACKUP (create queries)--

use database moviedb;

select get_ddl('database','moviedb');

create or replace database MOVIEDB;

create or replace schema DIM;

-- dimention tables

create or replace TABLE DIM_COMPANY (
	C_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	COMPANY VARCHAR(255)
);
create or replace TABLE DIM_COUNTRY (
	P_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	COUNTRY VARCHAR(50)
);
create or replace TABLE DIM_DIRECTOR (
	D_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	DIRECTOR VARCHAR(255)
);
create or replace TABLE DIM_GENRE (
	G_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	GENRE VARCHAR(50)
);
create or replace TABLE DIM_MOVIE_NAME (
	M_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	NAME VARCHAR(255)
);
create or replace TABLE DIM_RATING (
	R_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	RATING VARCHAR(10),
	FULLFORM VARCHAR(50)
);
create or replace TABLE DIM_STAR (
	S_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	STAR VARCHAR(255)
);
create or replace TABLE DIM_WRITER (
	W_ID NUMBER(38,0) autoincrement start 1 increment 1 noorder,
	WRITER VARCHAR(255)
);

-- fact tables

create or replace schema FACT;

create or replace TABLE FCT_MOVIES (
	M_ID NUMBER(38,0),
	R_ID NUMBER(38,0),
	G_ID NUMBER(38,0),
	RELEASED VARCHAR(255),
	MONTHINNAME VARCHAR(20),
	MONTH NUMBER(38,0),
	YEAR NUMBER(38,0),
	SCORE FLOAT,
	VOTES NUMBER(38,0),
	D_ID NUMBER(38,0),
	W_ID NUMBER(38,0),
	S_ID NUMBER(38,0),
	P_ID NUMBER(38,0),
	BUDGET NUMBER(38,0),
	GROSS NUMBER(38,0),
	C_ID NUMBER(38,0),
	RUNTIME NUMBER(38,0)
);

-- stage schema
create or replace schema STAGE;

create or replace TABLE MOVIESTAGE (
	NAME VARCHAR(255),
	RATING VARCHAR(10),
	GENRE VARCHAR(50),
	YEAR NUMBER(38,0),
	RELEASED VARCHAR(255),
	SCORE FLOAT,
	VOTES NUMBER(38,0),
	DIRECTOR VARCHAR(255),
	WRITER VARCHAR(255),
	STAR VARCHAR(255),
	COUNTRY VARCHAR(50),
	BUDGET NUMBER(38,0),
	GROSS NUMBER(38,0),
	COMPANY VARCHAR(255),
	RUNTIME NUMBER(38,0)
);

-- output csv dolwload --

select * from moviedb.stage.moviestage;

select * from moviedb.dim.dim_company;

select * from moviedb.dim.dim_country;

select * from moviedb.dim.dim_director;

select * from moviedb.dim.dim_genre;

select * from moviedb.dim.dim_movie_name;

select * from moviedb.dim.dim_movie_name;

select * from moviedb.dim.dim_rating;

select * from moviedb.dim.dim_star;

select * from moviedb.fact.fct_movies;