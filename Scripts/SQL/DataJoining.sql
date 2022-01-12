/***********************************************
**                MSc ANALYTICS 
**     DATA ENGINEERING PLATFORMS (MSCA 31012 7)
** File:   Data Engineering Project 
** Desc:   Data Cleaning and Joining with MySQL
** Auth:   Muhammad Ali Ahmad, Han-Yi Lin, Jaqueline Pezan, Vanshika Tibarewalla
** Date:   12/12/2021
************************************************/

-- -----------------------------------------------------
-- Creation of temporary tables
-- -----------------------------------------------------
USE `DataEngineering`;

## Name Basics 
   															 
DROP TABLE IF EXISTS tempdb.`name_basics_0`;
CREATE TABLE IF NOT EXISTS tempdb.`name_basics_0`
SELECT *, RIGHT(nconst, 7), 
RIGHT(title_1, 8) AS title_11, RIGHT(title_2, 8) AS title_22, RIGHT(title_3, 8) AS title_33, 
RIGHT(title_4, 8) AS title_44, RIGHT(title_5, 8) AS title_55, RIGHT(title_6, 8) AS title_66
FROM name_basics;  

DROP TABLE IF EXISTS tempdb.`name_basics`;
CREATE TABLE IF NOT EXISTS tempdb.`name_basics`
SELECT 
	nconst, primaryName, birthYear, 
    deathYear, Profession_1, Profession_2, 
    Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, 
    REPLACE(Title_11, 't', '9') AS title_01, 
    REPLACE(Title_22, 't', '9') AS title_02, 
    REPLACE(Title_33, 't', '9') AS title_03, 
    REPLACE(Title_44, 't', '9') AS title_04, 
    REPLACE(Title_55, 't', '9') AS title_05, 
    REPLACE(Title_66, 't', '9') AS title_06
FROM tempdb.`name_basics_0`;    

## Title Basics
DROP TABLE IF EXISTS tempdb.`title_basics`; 
CREATE TABLE IF NOT EXISTS tempdb.`title_basics` 
SELECT *, RIGHT(tconst, 8) AS tb_id FROM title_basics; 

DROP TABLE IF EXISTS tempdb.title_basics_1; 
CREATE TABLE IF NOT EXISTS tempdb.title_basics_1 
SELECT *, REPLACE(tb_id, 't', '9') AS tbid_1 FROM tempdb.title_basics; 

ALTER TABLE tempdb.title_basics_1 MODIFY COLUMN tbid_1 INT(30);

## Title Ratings 
DROP TABLE IF EXISTS tempdb.`title_ratings`; 
CREATE TABLE IF NOT EXISTS tempdb.`title_ratings` 
SELECT *, RIGHT(tconst, 8) AS tr_id FROM title_ratings; 

DROP TABLE IF EXISTS tempdb.title_ratings_1; 
CREATE TABLE IF NOT EXISTS tempdb.title_ratings_1
SELECT *, REPLACE(tr_id, 't', '9') AS trid_1 FROM tempdb.title_ratings; 

ALTER TABLE tempdb.title_ratings_1 MODIFY COLUMN trid_1 INT(30);


-- -----------------------------------------------------
-- Joining Data for our finalized summary table
-- -----------------------------------------------------

ALTER TABLE tempdb.title_ratings_1 ADD INDEX `xxidtr0` (trid_1);
ALTER TABLE tempdb.title_basics_1 ADD INDEX `idtb0` (tbid_1); 

DROP TABLE IF EXISTS tempdb.title_basics_ratings; 
CREATE TABLE IF NOT EXISTS tempdb.title_basics_ratings 
SELECT A.*, B.averageRating, B.numVotes, B.trid_1 
FROM tempdb.title_basics_1 A 
LEFT JOIN tempdb.title_ratings_1 B 
ON A.tbid_1 = B.trid_1; 

ALTER TABLE tempdb.name_basics ADD INDEX `idx011` (title_01);
ALTER TABLE tempdb.name_basics ADD INDEX `idx012` (title_02);
ALTER TABLE tempdb.name_basics ADD INDEX `idx013` (title_03);
ALTER TABLE tempdb.name_basics ADD INDEX `idx014` (title_04);
ALTER TABLE tempdb.name_basics ADD INDEX `idx015` (title_05);
ALTER TABLE tempdb.name_basics ADD INDEX `idx016` (title_06); 

DROP TABLE IF EXISTS tempdb.name_title_1; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_1
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_01 = B.trid_1; 


## Disposition Rate: 14.26% - Percentage of records in title_basics which were joined to a record in title_ratings 
## Match Rate: 100.00% - Percentage of records in title_ratings which were joined to a record in title_basics


DROP TABLE IF EXISTS tempdb.name_title_2; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_2
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_02 = B.trid_1; 

DROP TABLE IF EXISTS tempdb.name_title_3; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_3
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_03 = B.trid_1; 

DROP TABLE IF EXISTS tempdb.name_title_4; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_4
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_04 = B.trid_1; 

DROP TABLE IF EXISTS tempdb.name_title_5; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_5
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_05 = B.trid_1; 

DROP TABLE IF EXISTS tempdb.name_title_6; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_6
SELECT A.*, B.primaryTitle, B.OriginalTitle, B.AverageRating, B.numVotes, B.tconst AS matchedmovie 
FROM tempdb.name_basics A 
INNER JOIN tempdb.title_basics_ratings B  
ON A.title_06 = B.trid_1; 

DROP TABLE IF EXISTS tempdb.name_title_final; 
CREATE TABLE IF NOT EXISTS tempdb.name_title_final 
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_1 
UNION 
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_2 
UNION
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_3 
UNION
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_4 
UNION
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_5
UNION
SELECT 
	nconst, primaryName, BirthYear, DeathYear, Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, Title_4, Title_5, Title_6, PrimaryTitle, OriginalTitle, AverageRating, NumVotes, MatchedMovie
    FROM tempdb.name_title_6; 
    



