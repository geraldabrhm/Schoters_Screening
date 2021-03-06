-- Create and setup database
-- MySQL Script generated by MySQL Workbench
-- Fri Apr 15 07:01:19 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema schoters
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema schoters
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `schoters` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `schoters` ;

-- -----------------------------------------------------
-- Table `schoters`.`campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `schoters`.`campaign` (
  `campaign_name` VARCHAR(15) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `budget` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`campaign_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `schoters`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `schoters`.`customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `nama_customer` VARCHAR(35) NOT NULL,
  `domisili` VARCHAR(15) NOT NULL,
  `usia` INT NULL DEFAULT NULL,
  `campaign_engage` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  INDEX `campaign_engage_idx` (`campaign_engage` ASC) VISIBLE,
  CONSTRAINT `campaign_engage`
    FOREIGN KEY (`campaign_engage`)
    REFERENCES `schoters`.`campaign` (`campaign_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `schoters`.`transaksi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `schoters`.`transaksi` (
  `id_transaction` INT NOT NULL AUTO_INCREMENT,
  `id_customer` INT NOT NULL,
  `tanggal_transaksi` DATE NOT NULL,
  `nama_sales` VARCHAR(35) NOT NULL,
  `harga_asli` DECIMAL(10,2) NULL,
  `tipe_produk` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_transaction`),
  INDEX `id_customer_transaction_idx` (`id_customer` ASC) VISIBLE,
  CONSTRAINT `id_customer_transaction`
    FOREIGN KEY (`id_customer`)
    REFERENCES `schoters`.`customer` (`id_customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;