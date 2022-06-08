/*
 Navicat Premium Data Transfer

 Source Server         : Julian_Borys_MariaDB
 Source Server Type    : MariaDB
 Source Server Version : 100608
 Source Host           : localhost:3306
 Source Schema         : pbd_projekt_loty

 Target Server Type    : MariaDB
 Target Server Version : 100608
 File Encoding         : 65001

 Date: 09/06/2022 01:18:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blik
-- ----------------------------
DROP TABLE IF EXISTS `blik`;
CREATE TABLE `blik`  (
  `ID_Blik` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Platnosci` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Blik`) USING BTREE,
  INDEX `ID_Platnosci`(`ID_Platnosci`) USING BTREE,
  CONSTRAINT `blik_ibfk_1` FOREIGN KEY (`ID_Platnosci`) REFERENCES `platnosc` (`ID_Platnosc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for faktura
-- ----------------------------
DROP TABLE IF EXISTS `faktura`;
CREATE TABLE `faktura`  (
  `ID_Faktura` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Brutto` float UNSIGNED NOT NULL,
  `Netto` float UNSIGNED NOT NULL,
  `VAT` int(10) UNSIGNED NOT NULL,
  `NIP` int(20) UNSIGNED NOT NULL,
  `ID_Osoba` int(10) UNSIGNED NOT NULL,
  `ID_Przewoznik` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Faktura`) USING BTREE,
  INDEX `ID_Przewoznik`(`ID_Przewoznik`) USING BTREE,
  INDEX `ID_Osoba`(`ID_Osoba`) USING BTREE,
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`ID_Przewoznik`) REFERENCES `przewoznik` (`ID_Przewoznik`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `faktura_ibfk_2` FOREIGN KEY (`ID_Osoba`) REFERENCES `osoba` (`ID_Osoba`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for karta
-- ----------------------------
DROP TABLE IF EXISTS `karta`;
CREATE TABLE `karta`  (
  `ID_Karta` int(10) UNSIGNED NOT NULL,
  `ID_Platnosci` int(10) UNSIGNED NOT NULL,
  `Imie` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nazwisko` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nr_Karty` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CVV` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Data_wygasniecia` datetime NOT NULL,
  PRIMARY KEY (`ID_Karta`) USING BTREE,
  INDEX `ID_Platnosci`(`ID_Platnosci`) USING BTREE,
  CONSTRAINT `karta_ibfk_1` FOREIGN KEY (`ID_Platnosci`) REFERENCES `platnosc` (`ID_Platnosc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for klasy
-- ----------------------------
DROP TABLE IF EXISTS `klasy`;
CREATE TABLE `klasy`  (
  `ID_Klasy` int(10) UNSIGNED NOT NULL,
  `Koszt` float UNSIGNED NOT NULL,
  `ID_Samolot` int(10) UNSIGNED NOT NULL,
  `Ilosc_miejsc` int(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Klasy`) USING BTREE,
  INDEX `ID_Samolot`(`ID_Samolot`) USING BTREE,
  CONSTRAINT `klasy_ibfk_1` FOREIGN KEY (`ID_Samolot`) REFERENCES `samolot` (`ID_Samolot`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lot
-- ----------------------------
DROP TABLE IF EXISTS `lot`;
CREATE TABLE `lot`  (
  `ID_Lot` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Lotnisko_start` int(10) UNSIGNED NOT NULL,
  `Lotnisko_koniec` int(10) UNSIGNED NOT NULL,
  `Data_godzina_start` datetime NOT NULL,
  `Data_godzina_koniec` datetime NOT NULL,
  `ID_Samolot` int(10) UNSIGNED NOT NULL,
  `Dlugosc_lotu` float UNSIGNED NOT NULL,
  `Typ_Lotu` enum('Krajowy','Strefa_schengen','Non_schengen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ID_Przewoznik` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Lot`) USING BTREE,
  INDEX `ID_Przewoznik`(`ID_Przewoznik`) USING BTREE,
  INDEX `Lotnisko_start`(`Lotnisko_start`) USING BTREE,
  INDEX `Lotnisko_koniec`(`Lotnisko_koniec`) USING BTREE,
  INDEX `ID_Samolot`(`ID_Samolot`) USING BTREE,
  CONSTRAINT `lot_ibfk_1` FOREIGN KEY (`ID_Przewoznik`) REFERENCES `przewoznik` (`ID_Przewoznik`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_2` FOREIGN KEY (`Lotnisko_start`) REFERENCES `lotnisko` (`ID_Lotnisko`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_3` FOREIGN KEY (`Lotnisko_koniec`) REFERENCES `lotnisko` (`ID_Lotnisko`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_4` FOREIGN KEY (`ID_Samolot`) REFERENCES `samolot` (`ID_Samolot`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lotnisko
-- ----------------------------
DROP TABLE IF EXISTS `lotnisko`;
CREATE TABLE `lotnisko`  (
  `ID_Lotnisko` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Kraj` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nazwa_lotniska` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Strefa_czasowa` int(11) NOT NULL,
  `Miasto` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Lotnisko`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for osoba
-- ----------------------------
DROP TABLE IF EXISTS `osoba`;
CREATE TABLE `osoba`  (
  `ID_Osoba` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Login` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Haslo` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Mail` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Plec` enum('Kobieta','Mezczyzna','Inne') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Imie` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nazwisko` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Pesel` int(11) UNSIGNED NOT NULL,
  `Nr_dowodu/Paszportu` int(10) UNSIGNED NOT NULL,
  `Typ` enum('Uzytkownik','Administrator','Pracownik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nr_telefonu` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Osoba`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for platnosc
-- ----------------------------
DROP TABLE IF EXISTS `platnosc`;
CREATE TABLE `platnosc`  (
  `ID_Platnosc` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Typ_Platnosci` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Platnosc`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for przelew
-- ----------------------------
DROP TABLE IF EXISTS `przelew`;
CREATE TABLE `przelew`  (
  `ID_Przelew` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Platnosc` int(10) UNSIGNED NOT NULL,
  `Nazwa_przelewu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nr_Konta` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Przelew`) USING BTREE,
  INDEX `ID_Platnosc`(`ID_Platnosc`) USING BTREE,
  CONSTRAINT `przelew_ibfk_1` FOREIGN KEY (`ID_Platnosc`) REFERENCES `platnosc` (`ID_Platnosc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for przewoznik
-- ----------------------------
DROP TABLE IF EXISTS `przewoznik`;
CREATE TABLE `przewoznik`  (
  `ID_Przewoznik` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nazwa_Przewoznika` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NIP` int(20) UNSIGNED NOT NULL,
  `Siedziba_adres` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Przewoznik`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for samolot
-- ----------------------------
DROP TABLE IF EXISTS `samolot`;
CREATE TABLE `samolot`  (
  `ID_Samolot` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Ladownosc` float UNSIGNED NOT NULL,
  `Nr_samolotu` int(10) UNSIGNED NOT NULL,
  `Data_produkcji` date NOT NULL,
  PRIMARY KEY (`ID_Samolot`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for transakcja
-- ----------------------------
DROP TABLE IF EXISTS `transakcja`;
CREATE TABLE `transakcja`  (
  `ID_Transakcja` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Osoba` int(10) UNSIGNED NOT NULL,
  `ID_Lot` int(10) UNSIGNED NOT NULL,
  `Bagaż` int(10) UNSIGNED NOT NULL,
  `ID_Klasy` int(10) UNSIGNED NOT NULL,
  `Koszt` float UNSIGNED NOT NULL,
  `ID_Platnosc` int(10) UNSIGNED NOT NULL,
  `ID_Faktura` int(10) UNSIGNED NOT NULL,
  `Ilosc_przesiadek` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Transakcja`) USING BTREE,
  INDEX `ID_Platnosc`(`ID_Platnosc`) USING BTREE,
  INDEX `ID_Faktura`(`ID_Faktura`) USING BTREE,
  INDEX `ID_Klasy`(`ID_Klasy`) USING BTREE,
  INDEX `ID_Lot`(`ID_Lot`) USING BTREE,
  INDEX `ID_Osoba`(`ID_Osoba`) USING BTREE,
  CONSTRAINT `transakcja_ibfk_1` FOREIGN KEY (`ID_Platnosc`) REFERENCES `platnosc` (`ID_Platnosc`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_2` FOREIGN KEY (`ID_Faktura`) REFERENCES `faktura` (`ID_Faktura`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_3` FOREIGN KEY (`ID_Klasy`) REFERENCES `klasy` (`ID_Klasy`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_5` FOREIGN KEY (`ID_Lot`) REFERENCES `lot` (`ID_Lot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_6` FOREIGN KEY (`ID_Osoba`) REFERENCES `osoba` (`ID_Osoba`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
