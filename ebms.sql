-- Setting up the environment
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dropping existing tables if they exist
DROP TABLE IF EXISTS `account`;
DROP TABLE IF EXISTS `admin`;
DROP TABLE IF EXISTS `billing`;
DROP TABLE IF EXISTS `customer`;
DROP TABLE IF EXISTS `elec_board`;
DROP TABLE IF EXISTS `invoice`;
DROP TABLE IF EXISTS `tariff`;

-- Creating tables with defined constraints

-- Customer Table
CREATE TABLE `customer` (
  `cust_id` INT NOT NULL,
  `cust_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `state` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `pincode` INT NOT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Account Table
CREATE TABLE `account` (
  `acc_id` INT NOT NULL,
  `cust_id` INT DEFAULT NULL,
  `account_no` VARCHAR(50) DEFAULT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`acc_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Admin Table
CREATE TABLE `admin` (
  `admin_id` INT NOT NULL,
  `admin_name` VARCHAR(50) NOT NULL,
  `cust_id` INT DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Billing Table
CREATE TABLE `billing` (
  `meter_number` VARCHAR(10) NOT NULL,
  `acc_id` INT DEFAULT NULL,
  `cust_id` INT DEFAULT NULL,
  `monthly_units` INT DEFAULT NULL,
  `amount_per_unit` INT DEFAULT NULL,
  `total_amount` INT DEFAULT NULL,
  PRIMARY KEY (`meter_number`),
  KEY `acc_id` (`acc_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`acc_id`) REFERENCES `account` (`acc_id`),
  CONSTRAINT `billing_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Electricity Board Table
CREATE TABLE `elec_board` (
  `eboard_id` INT NOT NULL,
  `board_name` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`eboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tariff Table
CREATE TABLE `tariff` (
  `tariff_id` INT NOT NULL,
  `tariff_type` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`tariff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Invoice Table
CREATE TABLE `invoice` (
  `invoice_id` INT NOT NULL,
  `eboard_id` INT DEFAULT NULL,
  `account_no` VARCHAR(50) DEFAULT NULL,
  `tariff_id` INT DEFAULT NULL,
  `reading_date` DATE DEFAULT NULL,
  `meter_number` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `eboard_id` (`eboard_id`),
  KEY `tariff_id` (`tariff_id`),
  KEY `meter_number` (`meter_number`),
  CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`eboard_id`) REFERENCES `elec_board` (`eboard_id`),
  CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`tariff_id`) REFERENCES `tariff` (`tariff_id`),
  CONSTRAINT `invoice_ibfk_3` FOREIGN KEY (`meter_number`) REFERENCES `billing` (`meter_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting data into the tables

-- Customer Data
INSERT INTO `customer` VALUES 
(111,'Abhay','MG Road','Karnataka','Mysore',570008),
(112,'Vishnu','Basaveshwara Nagar','Karnataka','Bangalore',570042),
(113,'Anant','HD Kote Road','Karnataka','Mysore',570009),
-- Add remaining data...

-- Account Data
INSERT INTO `account` VALUES 
(401,111,'11345','Abhay'),
(403,112,'12455','Vishnu'),
(405,113,'98754','Anant'),
-- Add remaining data...

-- Admin Data
INSERT INTO `admin` VALUES 
(1,'Sahil',111),
(2,'Karan',112),
(3,'Rahul',113),
-- Add remaining data...

-- Billing Data
INSERT INTO `billing` VALUES 
('101',401,111,500,10,5000),
('102',403,112,390,10,3900),
('103',405,113,208,10,2080),
-- Add remaining data...

-- Electricity Board Data
INSERT INTO `elec_board` VALUES 
(1010,'Chamundeshwari Power Corporation'),
(2010,'Karnataka Power Corporation'),
(3010,'Bangalore Power Corporation'),
-- Add remaining data...

-- Tariff Data
INSERT INTO `tariff` VALUES 
(12,'Power factor tariff'),
(13,'Peak Load tariff'),
(14,'Two part tariff'),
(15,'Three part tariff');

-- Invoice Data
INSERT INTO `invoice` VALUES 
(1000,6010,'98764',12,'2020-06-10','110'),
(1047,4010,'91294',15,'2020-06-03','114'),
(1111,1010,'11345',12,'2020-06-23','101'),
-- Add remaining data...

-- Resetting environment settings
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
