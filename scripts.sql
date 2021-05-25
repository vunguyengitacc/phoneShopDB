-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`account` (
  `USERNAME` CHAR(20) NOT NULL,
  `PASSWORD` CHAR(20) NOT NULL,
  `EMAIL` CHAR(100) NULL DEFAULT NULL,
  `PHONE` CHAR(10) NULL DEFAULT NULL,
  `TYPE` INT UNSIGNED NOT NULL,
  `STATUS` TINYINT NOT NULL DEFAULT '1',
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `GENDER` TINYINT UNSIGNED NULL DEFAULT '0',
  `AVATAR` VARCHAR(500) NULL DEFAULT NULL,
  `reset_password_token` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`USERNAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`district`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`district` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`ward`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ward` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `DISTRICT_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_WARD_DISTRICT_idx` (`DISTRICT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_WARD_DISTRICT`
    FOREIGN KEY (`DISTRICT_ID`)
    REFERENCES `mydb`.`district` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`commune`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`commune` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `WARD_ID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_COMMUNE_WARD1_idx` (`WARD_ID` ASC) VISIBLE,
  CONSTRAINT `fk_COMMUNE_WARD1`
    FOREIGN KEY (`WARD_ID`)
    REFERENCES `mydb`.`ward` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promotion` (
  `ID` VARCHAR(50) NOT NULL,
  `VALUE` DECIMAL(5,2) UNSIGNED NOT NULL,
  `EXPIRED_DATE` DATETIME NOT NULL,
  `TYPE` INT UNSIGNED NOT NULL COMMENT '1: Per User\\\\n2: Per Day\\\\n3: Per Week\\\\n4: Per Month',
  `CREATED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bill` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TOTAL_VALUE` DECIMAL(20,2) UNSIGNED NOT NULL,
  `COMMUNE_ID` INT UNSIGNED NOT NULL,
  `PROMOTION_ID` VARCHAR(50) NULL DEFAULT NULL,
  `ACCOUNT_USERNAME` CHAR(20) NOT NULL,
  `STATUS` TINYINT NOT NULL DEFAULT '0',
  `CREATE_DATE` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_BILL_COMMUNE1_idx` (`COMMUNE_ID` ASC) VISIBLE,
  INDEX `fk_BILL_PROMOTION1_idx` (`PROMOTION_ID` ASC) VISIBLE,
  INDEX `fk_BILL_ACCOUNT1_idx` (`ACCOUNT_USERNAME` ASC) VISIBLE,
  CONSTRAINT `fk_BILL_COMMUNE1`
    FOREIGN KEY (`COMMUNE_ID`)
    REFERENCES `mydb`.`commune` (`ID`),
  CONSTRAINT `fk_BILL_PROMOTION1`
    FOREIGN KEY (`PROMOTION_ID`)
    REFERENCES `mydb`.`promotion` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 61
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`color` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`trademark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`trademark` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `ORIGINAL_PRICE` DECIMAL(20,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `PRICE` DECIMAL(20,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `PROMOTION_PRICE` DECIMAL(20,2) UNSIGNED NOT NULL DEFAULT '0.00',
  `IMAGE` VARCHAR(500) NULL DEFAULT '/resources/default.png',
  `DESCRIPTION` VARCHAR(1000) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `RAM` INT UNSIGNED NULL DEFAULT NULL,
  `ROM` INT UNSIGNED NULL DEFAULT NULL,
  `SCREEN_SIZE` DECIMAL(3,1) UNSIGNED NULL DEFAULT NULL,
  `FRONT_CAMERA` VARCHAR(45) NULL DEFAULT NULL,
  `BACK_CAMERA` VARCHAR(45) NULL DEFAULT NULL,
  `BATTERY_CAPACITY` INT UNSIGNED NULL DEFAULT NULL COMMENT 'Dung luong pin',
  `OS` VARCHAR(100) NULL DEFAULT NULL COMMENT 'He dieu hanh',
  `CPU` VARCHAR(100) NULL DEFAULT NULL,
  `GPU` VARCHAR(100) NULL DEFAULT NULL,
  `SIM` VARCHAR(100) NULL DEFAULT NULL,
  `TRADEMARK_ID` INT UNSIGNED NOT NULL,
  `CREATED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_PRODUCT_TRADEMARK1_idx` (`TRADEMARK_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT_TRADEMARK1`
    FOREIGN KEY (`TRADEMARK_ID`)
    REFERENCES `mydb`.`trademark` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 52
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CONTENT` VARCHAR(500) CHARACTER SET 'utf8' NOT NULL,
  `ACCOUNT_USERNAME` CHAR(20) NOT NULL,
  `PRODUCT_ID` INT UNSIGNED NOT NULL,
  `CREATE_DATE` DATETIME NULL DEFAULT NULL,
  `STATUS` TINYINT UNSIGNED NOT NULL DEFAULT '1' COMMENT '1: Hiện\\n0: Ẩn',
  PRIMARY KEY (`ID`),
  INDEX `fk_COMMENT_ACCOUNT1_idx` (`ACCOUNT_USERNAME` ASC) VISIBLE,
  INDEX `fk_COMMENT_PRODUCT1_idx` (`PRODUCT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_COMMENT_ACCOUNT1`
    FOREIGN KEY (`ACCOUNT_USERNAME`)
    REFERENCES `mydb`.`account` (`USERNAME`),
  CONSTRAINT `fk_COMMENT_PRODUCT1`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `mydb`.`product` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`general_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`general_information` (
  `EMAIL` VARCHAR(100) NOT NULL,
  `PHONE` CHAR(10) NOT NULL,
  `ADDRESS` VARCHAR(200) NOT NULL,
  `CREATED_DATE` DATETIME NOT NULL,
  PRIMARY KEY (`CREATED_DATE`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_has_color` (
  `COLOR_ID` INT UNSIGNED NOT NULL,
  `PRODUCT_ID` INT UNSIGNED NOT NULL,
  `AMOUNT` INT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`COLOR_ID`, `PRODUCT_ID`),
  INDEX `fk_PRODUCT_has_COLOR_PRODUCT1_idx` (`PRODUCT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT_has_COLOR_COLOR1`
    FOREIGN KEY (`COLOR_ID`)
    REFERENCES `mydb`.`color` (`ID`),
  CONSTRAINT `fk_PRODUCT_has_COLOR_PRODUCT1`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `mydb`.`product` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_color_has_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_has_color_has_bill` (
  `PRODUCT_has_COLOR_COLOR_ID` INT UNSIGNED NOT NULL,
  `PRODUCT_has_COLOR_PRODUCT_ID` INT UNSIGNED NOT NULL,
  `BILL_ID` INT UNSIGNED NOT NULL,
  `AMOUNT` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_has_COLOR_COLOR_ID`, `PRODUCT_has_COLOR_PRODUCT_ID`, `BILL_ID`),
  INDEX `fk_PRODUCT_has_COLOR_has_BILL_BILL1_idx` (`BILL_ID` ASC) VISIBLE,
  INDEX `fk_PRODUCT_has_COLOR_has_BILL_PRODUCT_has_COLOR1_idx` (`PRODUCT_has_COLOR_COLOR_ID` ASC, `PRODUCT_has_COLOR_PRODUCT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT_has_COLOR_has_BILL_BILL1`
    FOREIGN KEY (`BILL_ID`)
    REFERENCES `mydb`.`bill` (`ID`),
  CONSTRAINT `fk_PRODUCT_has_COLOR_has_BILL_PRODUCT_has_COLOR1`
    FOREIGN KEY (`PRODUCT_has_COLOR_COLOR_ID` , `PRODUCT_has_COLOR_PRODUCT_ID`)
    REFERENCES `mydb`.`product_has_color` (`COLOR_ID` , `PRODUCT_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rating` (
  `PRODUCT_ID` INT UNSIGNED NOT NULL,
  `ACCOUNT_USERNAME` CHAR(20) NOT NULL,
  `RATE` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`, `ACCOUNT_USERNAME`),
  INDEX `fk_PRODUCT_has_ACCOUNT_ACCOUNT1_idx` (`ACCOUNT_USERNAME` ASC) VISIBLE,
  INDEX `fk_PRODUCT_has_ACCOUNT_PRODUCT1_idx` (`PRODUCT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT_has_ACCOUNT_ACCOUNT1`
    FOREIGN KEY (`ACCOUNT_USERNAME`)
    REFERENCES `mydb`.`account` (`USERNAME`),
  CONSTRAINT `fk_PRODUCT_has_ACCOUNT_PRODUCT1`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `mydb`.`product` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`session` (
  `ID` VARCHAR(100) NOT NULL,
  `CREATE_DATE` DATETIME NULL DEFAULT NULL,
  `IS_SAVE` TINYINT NULL DEFAULT NULL,
  `IS_VALIDATE` TINYINT NULL DEFAULT '1',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
