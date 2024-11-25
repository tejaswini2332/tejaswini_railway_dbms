-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: rail
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!50503 SET NAMES utf8mb4 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Current Database: `rail`
--
DROP DATABASE IF EXISTS rail;
CREATE DATABASE rail;
USE rail;
--
-- Table structure for table `CITY_ZONE`
--

DROP TABLE IF EXISTS `CITY_ZONE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `CITY_ZONE` (
  `City_name` varchar(20) NOT NULL,
  `Zone_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`City_name`),
  CONSTRAINT `CITYFK` FOREIGN KEY (`City_name`) REFERENCES `STATION_LOCATION` (`City_name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `CITY_ZONE`
--

LOCK TABLES `CITY_ZONE` WRITE;
/*!40000 ALTER TABLE `CITY_ZONE` DISABLE KEYS */
;
INSERT INTO `CITY_ZONE`
VALUES ('Ahmedabad', 'Western'),
  ('Delhi', 'Northern'),
  ('Howrah', 'Eastern'),
  ('Hyderabad', 'South Central'),
  ('Mumbai', 'Central');
/*!40000 ALTER TABLE `CITY_ZONE` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `COACH`
--

DROP TABLE IF EXISTS `COACH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `COACH` (
  `Coach_ID` decimal(3, 0) NOT NULL,
  `Train_num` decimal(5, 0) NOT NULL,
  `Seats_per_coach` int DEFAULT NULL,
  `Coach_type` enum(
    'First AC',
    'Second AC',
    'Third AC',
    'Chair Car',
    'Sleeper'
  ) DEFAULT NULL,
  PRIMARY KEY (`Coach_ID`),
  KEY `COACH` (`Train_num`),
  CONSTRAINT `COACHFK` FOREIGN KEY (`Train_num`) REFERENCES `TRAIN` (`Train_number`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `COACH`
--

LOCK TABLES `COACH` WRITE;
/*!40000 ALTER TABLE `COACH` DISABLE KEYS */
;
INSERT INTO `COACH`
VALUES (001, 14263, 20, 'First AC'),
  (002, 15908, 50, 'Second AC'),
  (003, 40772, 65, 'Third AC'),
  (004, 50674, 90, 'Chair Car'),
  (005, 43390, 75, 'Sleeper');
/*!40000 ALTER TABLE `COACH` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `DEPENDENT_PASSENGER`
--

DROP TABLE IF EXISTS `DEPENDENT_PASSENGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `DEPENDENT_PASSENGER` (
  `Passenger_ID` char(5) NOT NULL,
  `Dependent_Passenger_ID` char(5) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`, `Dependent_Passenger_ID`),
  CONSTRAINT `DPFK` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `DPGENDER` CHECK (
    (
      (`Gender` = _utf8mb4 'M')
      or (`Gender` = _utf8mb4 'F')
      or (`Gender` = _utf8mb4 'O')
    )
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `DEPENDENT_PASSENGER`
--

LOCK TABLES `DEPENDENT_PASSENGER` WRITE;
/*!40000 ALTER TABLE `DEPENDENT_PASSENGER` DISABLE KEYS */
;
INSERT INTO `DEPENDENT_PASSENGER`
VALUES (
    'N5639',
    'N5640',
    'Hema',
    'Mishra',
    '1990-05-23',
    'F'
  ),
  (
    'N5639',
    'N5641',
    'Arjun',
    'Mishra',
    '2015-10-19',
    'M'
  ),
  (
    'S4080',
    'S4081',
    'Vaidehi',
    'Reddy',
    '2003-04-26',
    'F'
  ),
  (
    'M7294',
    'M7295',
    'Gayathri',
    'Sharma',
    '1950-11-30',
    'F'
  ),
  (
    'M7294',
    'M7296',
    'Narendra',
    'Sharma',
    '1949-03-09',
    'M'
  );
/*!40000 ALTER TABLE `DEPENDENT_PASSENGER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `DISCOUNT`
--

DROP TABLE IF EXISTS `DISCOUNT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `DISCOUNT` (
  `Passenger_ID` char(5) NOT NULL,
  `Refund_amt` decimal(10, 2) DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`),
  CONSTRAINT `DFK` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `DISCOUNT`
--

LOCK TABLES `DISCOUNT` WRITE;
/*!40000 ALTER TABLE `DISCOUNT` DISABLE KEYS */
;
INSERT INTO `DISCOUNT`
VALUES ('M7294', 100.00),
  ('N5639', 50.00),
  ('S4080', 80.00);
/*!40000 ALTER TABLE `DISCOUNT` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `DPSG_PHONE_NUMBER`
--

DROP TABLE IF EXISTS `DPSG_PHONE_NUMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `DPSG_PHONE_NUMBER` (
  `Passenger_ID` char(5) NOT NULL,
  `Dependent_Passenger_ID` char(5) NOT NULL,
  `Phone_number` decimal(10, 0) NOT NULL,
  PRIMARY KEY (
    `Passenger_ID`,
    `Dependent_Passenger_ID`,
    `Phone_number`
  ),
  CONSTRAINT `DPNFK` FOREIGN KEY (`Passenger_ID`, `Dependent_Passenger_ID`) REFERENCES `DEPENDENT_PASSENGER` (`Passenger_ID`, `Dependent_Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `DPSG_PHONE_NUMBER`
--

LOCK TABLES `DPSG_PHONE_NUMBER` WRITE;
/*!40000 ALTER TABLE `DPSG_PHONE_NUMBER` DISABLE KEYS */
;
INSERT INTO `DPSG_PHONE_NUMBER`
VALUES ('M7294', 'M7295', 6284100833),
  ('M7294', 'M7295', 8335162982),
  ('N5639', 'N5640', 9456199376),
  ('S4080', 'S4081', 7330938152);
/*!40000 ALTER TABLE `DPSG_PHONE_NUMBER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `EMPLOYEE`
--

DROP TABLE IF EXISTS `EMPLOYEE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `EMPLOYEE` (
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Employee_ID` char(6) NOT NULL,
  `Supervisor_ID` char(6) DEFAULT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Working_hours` decimal(2, 0) DEFAULT '48' NOT NULL,
  `Salary` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  KEY `SelfKey` (`Supervisor_ID`),
  CONSTRAINT `SelfKey` FOREIGN KEY (`Supervisor_ID`) REFERENCES `EMPLOYEE` (`Employee_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `EMPLOYEE`
--

LOCK TABLES `EMPLOYEE` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE` DISABLE KEYS */
;
INSERT INTO `EMPLOYEE`
VALUES (
    'Vivek',
    'Gupta',
    'CK1982',
    'RS6923',
    '1975-04-17',
    80,
    80000.00
  ),
  (
    'Raghav',
    'Verma',
    'MS7490',
    'TT5098',
    '1995-03-20',
    60,
    30000.00
  ),
  (
    'Ramaswamy',
    'Naidu',
    'RS6923',
    NULL,
    '1971-07-28',
    90,
    1000000.00
  ),
  (
    'Varun',
    'Saxena',
    'ST3901',
    'MS7490',
    '1992-09-05',
    50,
    20000.00
  ),
  (
    'Prateek',
    'Khandelwal',
    'TT5098',
    'CK1982',
    '1980-02-11',
    70,
    50000.00
  );
/*!40000 ALTER TABLE `EMPLOYEE` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `EMP_PHONE_NUMBER`
--

DROP TABLE IF EXISTS `EMP_PHONE_NUMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `EMP_PHONE_NUMBER` (
  `Employee_ID` char(6) NOT NULL,
  `Phone_number` decimal(10, 0) NOT NULL,
  PRIMARY KEY (`Employee_ID`, `Phone_number`),
  CONSTRAINT `EPNFK` FOREIGN KEY (`Employee_ID`) REFERENCES `EMPLOYEE` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `EMP_PHONE_NUMBER`
--

LOCK TABLES `EMP_PHONE_NUMBER` WRITE;
/*!40000 ALTER TABLE `EMP_PHONE_NUMBER` DISABLE KEYS */
;
INSERT INTO `EMP_PHONE_NUMBER`
VALUES ('CK1982', 7418925509),
  ('MS7490', 9005441226),
  ('RS6923', 9317806655),
  ('RS6923', 9517534682),
  ('ST3901', 6554901234),
  ('TT5098', 8361908233);
/*!40000 ALTER TABLE `EMP_PHONE_NUMBER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `EMP_WORKING_DAYS`
--

DROP TABLE IF EXISTS `EMP_WORKING_DAYS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `EMP_WORKING_DAYS` (
  `Employee_ID` char(6) NOT NULL,
  `Day` enum('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun') NOT NULL,
  PRIMARY KEY (`Employee_ID`, `Day`),
  CONSTRAINT `EWDFK` FOREIGN KEY (`Employee_ID`) REFERENCES `EMPLOYEE` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `EMP_WORKING_DAYS`
--

LOCK TABLES `EMP_WORKING_DAYS` WRITE;
/*!40000 ALTER TABLE `EMP_WORKING_DAYS` DISABLE KEYS */
;
INSERT INTO `EMP_WORKING_DAYS`
VALUES ('CK1982', 'Mon'),
  ('CK1982', 'Wed'),
  ('CK1982', 'Fri'),
  ('MS7490', 'Tue'),
  ('MS7490', 'Thu'),
  ('MS7490', 'Sat'),
  ('RS6293', 'Mon'),
  ('RS6293', 'Tue'),
  ('RS6293', 'Wed'),
  ('RS6293', 'Thu'),
  ('RS6293', 'Fri'),
  ('RS6293', 'Sat'),
  ('RS6293', 'Sun'),
  ('ST3901', 'Mon'),
  ('ST3901', 'Tue'),
  ('ST3901', 'Wed'),
  ('TT5098', 'Thu'),
  ('TT5098', 'Fri'),
  ('TT5098', 'Sat');
/*!40000 ALTER TABLE `EMP_WORKING_DAYS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `FARE`
--

DROP TABLE IF EXISTS `FARE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `FARE` (
  `Ticket_ID` decimal(6, 0) NOT NULL,
  `Payment_ID` char(8) NOT NULL,
  `Payment_type` enum('Cash', 'Credit', 'Debit', 'UPI', 'NetBanking') DEFAULT NULL,
  `Amount` decimal(10, 2) DEFAULT NULL,
  `Payment_date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`Ticket_ID`, `Payment_ID`),
  CONSTRAINT `FFK` FOREIGN KEY (`Ticket_ID`) REFERENCES `TICKET` (`Ticket_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `FARE`
--

INSERT INTO `FARE`
VALUES (
    789654,
    'NB7342',
    'NetBanking',
    640.67,
    '2022-11-14 10:33:30'
  ),
  (
    902347,
    'UP8902',
    'UPI',
    430.39,
    '2022-11-07 16:23:09'
  ),
  (
    293845,
    'CD2385',
    'Credit',
    258.90,
    '2022-11-15 12:23:09'
  ),
  (
    926856,
    'DB9283',
    'Debit',
    339.85,
    '2022-10-31 09:13:09'
  ),
  (
    739765,
    'CS4390',
    'Cash',
    120.00,
    '2022-10-29 19:45:38'
  );
--
-- Table structure for table `MILITARY`
--

DROP TABLE IF EXISTS `MILITARY`;
CREATE TABLE `MILITARY` (
  `Passenger_ID` char(5) NOT NULL,
  `Military_ID` decimal(8, 0) NOT NULL,
  PRIMARY KEY (`Passenger_ID`, `Military_ID`),
  CONSTRAINT `MFK` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
);
--
-- Dumping data for table `MILITARY`
--

INSERT INTO `MILITARY`
VALUES ('M7294', 17342960);
--
-- Table structure for table `PASSENGER`
--

DROP TABLE IF EXISTS `PASSENGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `PASSENGER` (
  `Passenger_ID` char(5) NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`),
  CONSTRAINT `PGENDER` CHECK (
    (
      (`Gender` = _utf8mb4 'M')
      or (`Gender` = _utf8mb4 'F')
      or (`Gender` = _utf8mb4 'O')
    )
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `PASSENGER`
--

LOCK TABLES `PASSENGER` WRITE;
/*!40000 ALTER TABLE `PASSENGER` DISABLE KEYS */
;
INSERT INTO `PASSENGER`
VALUES ('F8709', 'Priya', 'Sharma', '1979-09-13', 'F'),
  (
    'K9825',
    'Anjali',
    'Parameswaran',
    '2000-03-09',
    'F'
  ),
  ('M7294', 'Vishnu', 'Sharma', '1974-12-12', 'M'),
  ('N5639', 'Aditya', 'Mishra', '1990-01-03', 'M'),
  ('P2095', 'Sriya', 'Shetty', '1989-02-14', 'F'),
  ('S4080', 'Santhosh', 'Reddy', '2003-08-14', 'M');
/*!40000 ALTER TABLE `PASSENGER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `PSG_PHONE_NUMBER`
--

DROP TABLE IF EXISTS `PSG_PHONE_NUMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `PSG_PHONE_NUMBER` (
  `Passenger_ID` char(5) NOT NULL,
  `Phone_number` decimal(10, 0) NOT NULL,
  PRIMARY KEY (`Passenger_ID`, `Phone_number`),
  CONSTRAINT `PPNFK` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `PSG_PHONE_NUMBER`
--

LOCK TABLES `PSG_PHONE_NUMBER` WRITE;
/*!40000 ALTER TABLE `PSG_PHONE_NUMBER` DISABLE KEYS */
;
INSERT INTO `PSG_PHONE_NUMBER`
VALUES ('K9825', 7659381464),
  ('M7294', 9532866081),
  ('N5639', 6689234109),
  ('N5639', 6729845691),
  ('S4080', 9182237236);
/*!40000 ALTER TABLE `PSG_PHONE_NUMBER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `SEAT`
--

DROP TABLE IF EXISTS `SEAT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `SEAT` (
  `Coach_ID` DECIMAL(3, 0) NOT NULL,
  `Seat_num` char(3) NOT NULL,
  `Seat_type` enum('EC', '1A', '2A', '3A', 'FC', 'CC', 'SL', '2S') DEFAULT NULL,
  `Availability` enum('A', 'NA') DEFAULT NULL,
  PRIMARY KEY (`Coach_ID`, `Seat_num`),
  CONSTRAINT `SFK` FOREIGN KEY (`Coach_ID`) REFERENCES `COACH` (`Coach_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `SEAT`
--

LOCK TABLES `SEAT` WRITE;
/*!40000 ALTER TABLE `SEAT` DISABLE KEYS */
;
INSERT INTO `SEAT`
VALUES (001, '18', '1A', 'NA'),
  (002, '45', '2A', 'A'),
  (003, '60', '3A', 'A'),
  (004, '75', 'CC', 'NA'),
  (005, '14', 'SL', 'A');
/*!40000 ALTER TABLE `SEAT` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `STATION`
--

DROP TABLE IF EXISTS `STATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `STATION` (
  `Station_Code` decimal(5, 0) NOT NULL,
  `Station_name` varchar(20) NOT NULL,
  PRIMARY KEY (`Station_Code`, `Station_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `STATION`
--

LOCK TABLES `STATION` WRITE;
/*!40000 ALTER TABLE `STATION` DISABLE KEYS */
;
INSERT INTO `STATION`
VALUES (12345, 'Secunderabad'),
  (18967, 'KolkataCLT'),
  (49278, 'AhmedabadCLT'),
  (76432, 'Bandra'),
  (90323, 'HauzKhaz');
/*!40000 ALTER TABLE `STATION` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `STATION_LOCATION`
--

DROP TABLE IF EXISTS `STATION_LOCATION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `STATION_LOCATION` (
  `Station_Code` decimal(5, 0) NOT NULL,
  `City_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Station_Code`),
  UNIQUE KEY `City_name` (`City_name`),
  CONSTRAINT `SLFK` FOREIGN KEY (`Station_Code`) REFERENCES `STATION` (`Station_Code`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `STATION_LOCATION`
--

LOCK TABLES `STATION_LOCATION` WRITE;
/*!40000 ALTER TABLE `STATION_LOCATION` DISABLE KEYS */
;
INSERT INTO `STATION_LOCATION`
VALUES (49278, 'Ahmedabad'),
  (90323, 'Delhi'),
  (18967, 'Howrah'),
  (12345, 'Hyderabad'),
  (76432, 'Mumbai');
/*!40000 ALTER TABLE `STATION_LOCATION` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `STUDENT`
--

DROP TABLE IF EXISTS `STUDENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `STUDENT` (
  `Passenger_ID` char(5) NOT NULL,
  `Student_ID` decimal(6, 0) NOT NULL,
  PRIMARY KEY (`Passenger_ID`, `Student_ID`),
  CONSTRAINT `STUFK` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `STUDENT`
--

LOCK TABLES `STUDENT` WRITE;
/*!40000 ALTER TABLE `STUDENT` DISABLE KEYS */
;
INSERT INTO `STUDENT`
VALUES ('S4080', 2021101);
/*!40000 ALTER TABLE `STUDENT` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `TICKET`
--

DROP TABLE IF EXISTS `TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TICKET` (
  `Ticket_ID` decimal(6, 0) NOT NULL,
  `Dept_Date` date NOT NULL,
  `Dept_Time` time NOT NULL,
  `Arr_Date` date NOT NULL,
  `Arr_Time` time NOT NULL,
  PRIMARY KEY (`Ticket_ID`)
);
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `TICKET`
--

LOCK TABLES `TICKET` WRITE;
/*!40000 ALTER TABLE `TICKET` DISABLE KEYS */
;
INSERT INTO `TICKET`
VALUES (
    293845,
    '2022-11-27',
    '08:15:00',
    '2022-11-27',
    '23:15:00'
  ),
  (
    739765,
    '2022-11-18',
    '22:20:00',
    '2022-11-19',
    '06:30:00'
  ),
  (
    789654,
    '2022-11-15',
    '13:10:00',
    '2022-11-15',
    '21:55:00'
  ),
  (
    902347,
    '2022-11-20',
    '04:35:00',
    '2022-11-21',
    '12:05:00'
  ),
  (
    926856,
    '2022-11-10',
    '10:15:00',
    '2022-11-10',
    '23:00:00'
  );
/*!40000 ALTER TABLE `TICKET` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `TRAIN`
--

DROP TABLE IF EXISTS `TRAIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TRAIN` (
  `Train_number` decimal(5, 0) NOT NULL,
  `Train_name` varchar(20) NOT NULL,
  PRIMARY KEY (`Train_number`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `TRAIN`
--

LOCK TABLES `TRAIN` WRITE;
/*!40000 ALTER TABLE `TRAIN` DISABLE KEYS */
;
INSERT INTO `TRAIN`
VALUES (14263, 'Rajdhani'),
  (15908, 'Duronto'),
  (40772, 'Amaravathi'),
  (43390, 'Shatabdi'),
  (50674, 'Charminar');
/*!40000 ALTER TABLE `TRAIN` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `TRAIN_DETAILS`
--

DROP TABLE IF EXISTS `TRAIN_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TRAIN_DETAILS` (
  `Train_number` decimal(5, 0) NOT NULL,
  `Dept_date` date DEFAULT NULL,
  `Dept_time` time DEFAULT NULL,
  `Arr_date` date DEFAULT NULL,
  `Arr_time` time DEFAULT NULL,
  `Dept_Station_Code` decimal(5, 0) DEFAULT NULL,
  `Arr_Station_Code` decimal(5, 0) DEFAULT NULL,
  `Distance` decimal(10, 2) DEFAULT NULL,
  PRIMARY KEY (`Train_number`),
  KEY `DPTFK` (`Dept_Station_Code`),
  KEY `ARFK` (`Arr_Station_Code`),
  CONSTRAINT `ARFK` FOREIGN KEY (`Arr_Station_Code`) REFERENCES `STATION` (`Station_Code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `DPTFK` FOREIGN KEY (`Dept_Station_Code`) REFERENCES `STATION` (`Station_Code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TFK` FOREIGN KEY (`Train_number`) REFERENCES `TRAIN` (`Train_number`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `TRAIN_DETAILS`
--

LOCK TABLES `TRAIN_DETAILS` WRITE;
/*!40000 ALTER TABLE `TRAIN_DETAILS` DISABLE KEYS */
;
INSERT INTO `TRAIN_DETAILS`
VALUES (
    14263,
    '2022-11-15',
    '13:10:00',
    '2022-11-15',
    '21:55:00',
    90323,
    49278,
    500.09
  ),
  (
    15908,
    '2022-11-10',
    '10:15:00',
    '2022-11-10',
    '23:00:00',
    76432,
    90323,
    1436.00
  ),
  (
    40772,
    '2022-11-18',
    '22:20:00',
    '2022-11-19',
    '06:30:00',
    76432,
    18967,
    430.45
  ),
  (
    43390,
    '2022-11-27',
    '08:15:00',
    '2022-11-27',
    '23:15:00',
    12345,
    76432,
    709.06
  ),
  (
    50674,
    '2022-11-20',
    '04:35:00',
    '2022-11-21',
    '12:05:00',
    12345,
    90323,
    890.00
  );
/*!40000 ALTER TABLE `TRAIN_DETAILS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `TRAVEL`
--

DROP TABLE IF EXISTS `TRAVEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `TRAVEL` (
  `Arr_Station_Code` decimal(5, 0) NOT NULL,
  `Arr_Station_Name` varchar(20) NOT NULL,
  `Dept_Station_Code` decimal(5, 0) NOT NULL,
  `Dept_Station_Name` varchar(20) NOT NULL,
  `Train_number` decimal(5, 0) NOT NULL,
  `Train_name` varchar(20) NOT NULL,
  `Ticket_ID` decimal(6, 0) NOT NULL,
  `Passenger_ID` char(5) NOT NULL,
  PRIMARY KEY (
    `Arr_Station_Code`,
    `Arr_Station_Name`,
    `Dept_Station_Code`,
    `Dept_Station_Name`,
    `Train_name`,
    `Train_number`,
    `Ticket_ID`,
    `Passenger_ID`
  ),
  KEY `TRNFK` (`Train_number`),
  KEY `DPRFK` (`Dept_Station_Code`, `Dept_Station_Name`),
  KEY `TIFK` (`Ticket_ID`),
  KEY `PSID` (`Passenger_ID`),
  CONSTRAINT `ASFK` FOREIGN KEY (`Arr_Station_Code`, `Arr_Station_Name`) REFERENCES `STATION` (`Station_Code`, `Station_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `DPRFK` FOREIGN KEY (`Dept_Station_Code`, `Dept_Station_Name`) REFERENCES `STATION` (`Station_Code`, `Station_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `PSID` FOREIGN KEY (`Passenger_ID`) REFERENCES `PASSENGER` (`Passenger_ID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TIFK` FOREIGN KEY (`Ticket_ID`) REFERENCES `TICKET` (`Ticket_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TRNFK` FOREIGN KEY (`Train_number`) REFERENCES `TRAIN` (`Train_number`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `TRAVEL`
--

LOCK TABLES `TRAVEL` WRITE;
/*!40000 ALTER TABLE `TRAVEL` DISABLE KEYS */
;
INSERT INTO `TRAVEL`
VALUES (
    90323,
    'HauzKhaz',
    49278,
    'AhmedabadCLT',
    14263,
    'Rajdhani',
    789654,
    'F8709'
  ),
  (
    90323,
    'HauzKhaz',
    49278,
    'AhmedabadCLT',
    14263,
    'Rajdhani',
    789654,
    'M7294'
  ),
  (
    76432,
    'Bandra',
    90323,
    'HauzKhaz',
    15908,
    'Duronto',
    926856,
    'P2095'
  ),
  (
    76432,
    'Bandra',
    18967,
    'KolkataCLT',
    40772,
    'Amaravathi',
    739765,
    'S4080'
  ),
  (
    12345,
    'Secunderabad',
    76432,
    'Bandra',
    43390,
    'Shatabdi',
    293845,
    'K9825'
  ),
  (
    12345,
    'Secunderabad',
    90323,
    'HauzKhaz',
    50674,
    'Charminar',
    902347,
    'N5639'
  );
/*!40000 ALTER TABLE `TRAVEL` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `WORK_FOR`
--

DROP TABLE IF EXISTS `WORK_FOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `WORK_FOR` (
  `Employee_ID` char(6) NOT NULL,
  `Station_Code` decimal(5, 0) NOT NULL,
  `Station_name` varchar(20) NOT NULL,
  `Train_number` decimal(5, 0) NOT NULL,
  `Train_name` varchar(20) NOT NULL,
  PRIMARY KEY (
    `Employee_ID`,
    `Station_Code`,
    `Station_name`,
    `Train_number`,
    `Train_name`
  ),
  KEY `TrFK` (`Train_number`),
  KEY `SCFK` (`Station_Code`, `Station_name`),
  CONSTRAINT `EFK` FOREIGN KEY (`Employee_ID`) REFERENCES `EMPLOYEE` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SCFK` FOREIGN KEY (`Station_Code`, `Station_name`) REFERENCES `STATION` (`Station_Code`, `Station_name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TrFK` FOREIGN KEY (`Train_number`) REFERENCES `TRAIN` (`Train_number`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `WORK_FOR`
--

LOCK TABLES `WORK_FOR` WRITE;
/*!40000 ALTER TABLE `WORK_FOR` DISABLE KEYS */
;
INSERT INTO `WORK_FOR`
VALUES (
    'MS7490',
    49278,
    'AhmedabadCLT',
    14263,
    'Rajdhani'
  ),
  ('TT5098', 90323, 'HauzKhaz', 14263, 'Rajdhani'),
  ('ST3901', 76432, 'Bandra', 15908, 'Duronto'),
  (
    'CK1982',
    18967,
    'KolkataCLT',
    40772,
    'Amaravathi'
  ),
  (
    'RS6923',
    12345,
    'Secunderabad',
    50674,
    'Charminar'
  );
/*!40000 ALTER TABLE `WORK_FOR` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2022-11-16 22:45:33