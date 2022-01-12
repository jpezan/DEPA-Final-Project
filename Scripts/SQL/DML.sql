/***********************************************
**                MSc ANALYTICS 
**     DATA ENGINEERING PLATFORMS (MSCA 31012)
** File:   Data Engineering DML 
** Desc:   ETL/DML for the movies dataset on IMDB
** Auth:   Muhammad Ali Ahmad, Vanshika Tibarewalla, Jacqueline Pezan, Hanyi Lin
** Date:   02/24/2019
** ALL RIGHTS RESERVED | DO NOT DISTRIBUTE
************************************************/


USE DataEngineering;

-- -----------------------------------------------------
-- Table `DataEngineering`.`Name_Basics`
-- -----------------------------------------------------
INSERT INTO DataEngineering.Name_Basics (PrimaryName, BirthYear, DeathYear,
    Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, 
    Title_4, Title_5, Title_6, Nconst)
(SELECT 
    primaryName,birthYear,deathYear,
    Profession_1, Profession_2, Profession_3, 
    Title_1, Title_2, Title_3, 
    Title_4, Title_5, Title_6, Nconst
FROM
    depa.name_basics);

-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Basics`
-- -----------------------------------------------------
INSERT INTO DataEngineering.Title_Basics (tconst, titleType, primaryTitle,
    OriginalTitle, isAdult, StartYear, 
    endYear, runTimeMinutes, Genre1, 
    Genre2, Genre3)
(SELECT 
    tconst, titleType, primaryTitle,
    OriginalTitle, isAdult, StartYear, 
    endYear, runTimeMinutes, Genre1, 
    Genre2, Genre3
FROM
    depa.title_basics);

-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Crew`
-- -----------------------------------------------------
INSERT INTO DataEngineering.Title_Crew (tconst, directors, writers)
(SELECT 
    tconst, directors, writers
FROM
    depa.title_crew);

-- -----------------------------------------------------
-- Table `DataEngineering`.`tile_principals`
-- -----------------------------------------------------
INSERT INTO DataEngineering.Title_Principals (tconst, ordering, nconst, category, job, characters)
(SELECT 
    tconst, ordering, nconst, category, job, characters
FROM
    depa.title_principals);

-- -----------------------------------------------------
-- Table `DataEngineering`.`title_ratings`
-- -----------------------------------------------------

INSERT INTO DataEngineering.title_ratings (tconst, averageRating, numVotes)
(SELECT 
    tconst, averageRating, numVotes
FROM
    depa.title_ratings);





