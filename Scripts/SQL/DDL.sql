
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DataEngineering
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DataEngineering` ;

-- -----------------------------------------------------
-- Schema DataEngineering
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DataEngineering` DEFAULT CHARACTER SET utf8 ;
USE `DataEngineering` ;

-- -----------------------------------------------------
-- Table `DataEngineering`.`Name_Basics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataEngineering`.`Name_Basics` ;

CREATE TABLE IF NOT EXISTS `DataEngineering`.`Name_Basics` (
  `PrimaryName` VARCHAR(45) NULL,
  `BirthYear` YEAR(4) NULL,
  `DeathYear` YEAR(4) NULL,
  `Profession_1` VARCHAR(45) NULL,
  `Profession_2` VARCHAR(45) NULL,
  `Profession_3` VARCHAR(45) NULL,
  `Title_1` VARCHAR(45) NULL,
  `Title_2` VARCHAR(45) NULL,
  `Title_3` VARCHAR(45) NULL,
  `Title_4` VARCHAR(45) NULL,
  `Title_5` VARCHAR(45) NULL,
  `Title_6` VARCHAR(45) NULL,
  `nconst` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`nconst`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Crew`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataEngineering`.`Title_Crew` ;

CREATE TABLE IF NOT EXISTS `DataEngineering`.`Title_Crew` (
  `tconst` VARCHAR(20) NOT NULL,
  `Directors` VARCHAR(45) NULL,
  `Writers` VARCHAR(45) NULL,
  PRIMARY KEY (`tconst`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Basics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataEngineering`.`Title_Basics` ;

CREATE TABLE IF NOT EXISTS `DataEngineering`.`Title_Basics` (
  `tconst` VARCHAR(20) NOT NULL,
  `titleType` VARCHAR(45) NULL,
  `PrimaryTitle` VARCHAR(45) NULL,
  `OriginalTitle` VARCHAR(45) NULL,
  `isAdult` INT(10) NULL,
  `StartYear` YEAR(4) NULL,
  `EndYear` YEAR(4) NULL,
  `runtimeMinutes` VARCHAR(45) NULL,
  `Genre1` VARCHAR(45) NULL,
  `Genre2` VARCHAR(45) NULL,
  `Genre3` VARCHAR(45) NULL,
  PRIMARY KEY (`tconst`),
  CONSTRAINT `fk_Title_Basics_Title_Crew1`
    FOREIGN KEY (`tconst`)
    REFERENCES `DataEngineering`.`Title_Crew` (`tconst`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Principals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataEngineering`.`Title_Principals` ;

CREATE TABLE IF NOT EXISTS `DataEngineering`.`Title_Principals` (
  `tconst` VARCHAR(20) NOT NULL,
  `Ordering` INT(20) NULL,
  `nconst` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NULL,
  `job` VARCHAR(45) NULL,
  `directors` VARCHAR(45) NULL,
  PRIMARY KEY (`nconst`, `tconst`),
  INDEX `fk_Title_Principals_Title_Basics1_idx` (`tconst` ASC) VISIBLE,
  CONSTRAINT `fk_Title_Principals_Name_Basics`
    FOREIGN KEY (`nconst`)
    REFERENCES `DataEngineering`.`Name_Basics` (`nconst`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Title_Principals_Title_Basics1`
    FOREIGN KEY (`tconst`)
    REFERENCES `DataEngineering`.`Title_Basics` (`tconst`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataEngineering`.`Title_Ratings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataEngineering`.`Title_Ratings` ;

CREATE TABLE IF NOT EXISTS `DataEngineering`.`Title_Ratings` (
  `tconst` VARCHAR(20) NOT NULL,
  `averageRating` VARCHAR(45) NULL,
  `numVotes` VARCHAR(45) NULL,
  PRIMARY KEY (`tconst`),
  CONSTRAINT `fk_Title_Ratings_Title_Basics1`
    FOREIGN KEY (`tconst`)
    REFERENCES `DataEngineering`.`Title_Basics` (`tconst`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
