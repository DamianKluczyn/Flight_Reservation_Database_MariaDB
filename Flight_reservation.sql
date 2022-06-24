/*
 Navicat Premium Data Transfer

 Source Server         : projekt
 Source Server Type    : MariaDB
 Source Server Version : 100424
 Source Host           : localhost:3306
 Source Schema         : pbd_lotnisko_last

 Target Server Type    : MariaDB
 Target Server Version : 100424
 File Encoding         : 65001

 Date: 21/06/2022 23:30:43
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blik
-- ----------------------------

-- ----------------------------
-- Table structure for faktura
-- ----------------------------
DROP TABLE IF EXISTS `faktura`;
CREATE TABLE `faktura`  (
  `ID_Faktura` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Brutto` float UNSIGNED NOT NULL,
  `Netto` float UNSIGNED NOT NULL,
  `VAT` int(10) UNSIGNED NOT NULL,
  `NIP` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Data_faktury` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Faktura`, `Data_faktury`) USING BTREE,
  INDEX `ID_Faktura`(`ID_Faktura`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic PARTITION BY RANGE (year(`Data_faktury`))
PARTITIONS 8
(PARTITION `mniejsze_od_2017` VALUES LESS THAN (2017) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2018` VALUES LESS THAN (2018) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2019` VALUES LESS THAN (2019) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2020` VALUES LESS THAN (2020) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2021` VALUES LESS THAN (2021) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2022` VALUES LESS THAN (2022) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `mniejsze_od_2023` VALUES LESS THAN (2023) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `wieksze_od_2023` VALUES LESS THAN (MAXVALUE) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- Records of faktura
-- ----------------------------

-- ----------------------------
-- Table structure for karta
-- ----------------------------
DROP TABLE IF EXISTS `karta`;
CREATE TABLE `karta`  (
  `ID_Karta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Platnosci` int(10) UNSIGNED NOT NULL,
  `Nr_Karty` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CVV` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Data_wygasniecia` date NOT NULL,
  PRIMARY KEY (`ID_Karta`) USING BTREE,
  INDEX `ID_Platnosci`(`ID_Platnosci`) USING BTREE,
  CONSTRAINT `karta_ibfk_1` FOREIGN KEY (`ID_Platnosci`) REFERENCES `platnosc` (`ID_Platnosc`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of karta
-- ----------------------------

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
  `Dlugosc_lotu` time NOT NULL,
  `Typ_Lotu` enum('Krajowy','Strefa_schengen','Non_schengen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ID_Przewoznik` int(10) UNSIGNED NOT NULL,
  `Dostepna_ladownosc` float NULL DEFAULT NULL,
  `Ilosc_wolnych_miejsc_klasa0` int(11) UNSIGNED NULL DEFAULT NULL,
  `Ilosc_wolnych_miejsc_klasa1` int(11) NULL DEFAULT NULL,
  `Ilosc_wolnych_miejsc_klasa2` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Lot`) USING BTREE,
  INDEX `ID_Przewoznik`(`ID_Przewoznik`) USING BTREE,
  INDEX `Lotnisko_start`(`Lotnisko_start`) USING BTREE,
  INDEX `Lotnisko_koniec`(`Lotnisko_koniec`) USING BTREE,
  INDEX `ID_Samolot`(`ID_Samolot`) USING BTREE,
  CONSTRAINT `lot_ibfk_1` FOREIGN KEY (`ID_Przewoznik`) REFERENCES `przewoznik` (`ID_Przewoznik`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_2` FOREIGN KEY (`Lotnisko_start`) REFERENCES `lotnisko` (`ID_Lotnisko`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_3` FOREIGN KEY (`Lotnisko_koniec`) REFERENCES `lotnisko` (`ID_Lotnisko`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lot_ibfk_4` FOREIGN KEY (`ID_Samolot`) REFERENCES `samolot` (`ID_Samolot`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lot
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lotnisko
-- ----------------------------

-- ----------------------------
-- Table structure for osoba
-- ----------------------------
DROP TABLE IF EXISTS `osoba`;
CREATE TABLE `osoba`  (
  `ID_Osoba` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Login` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Haslo` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Mail` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Plec` enum('Kobieta','Mezczyzna','Inne') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Imie` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nazwisko` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Pesel` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Nr_dowodu/Paszportu` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ID_typ_konta` int(10) UNSIGNED NOT NULL,
  `Nr_telefonu` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Osoba`) USING BTREE,
  INDEX `typ_konta`(`ID_typ_konta`) USING BTREE,
  CONSTRAINT `typ_konta` FOREIGN KEY (`ID_typ_konta`) REFERENCES `typ_konta` (`ID_typ_konta`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of osoba
-- ----------------------------

-- ----------------------------
-- Table structure for platnosc
-- ----------------------------
DROP TABLE IF EXISTS `platnosc`;
CREATE TABLE `platnosc`  (
  `ID_Platnosc` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Typ_Platnosci` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ID_Transakcja` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Platnosc`) USING BTREE,
  INDEX `ID_Transakcja`(`ID_Transakcja`) USING BTREE,
  CONSTRAINT `platnosc_ibfk_1` FOREIGN KEY (`ID_Transakcja`) REFERENCES `transakcja` (`ID_Transakcja`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of platnosc
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of przelew
-- ----------------------------

-- ----------------------------
-- Table structure for przewoznik
-- ----------------------------
DROP TABLE IF EXISTS `przewoznik`;
CREATE TABLE `przewoznik`  (
  `ID_Przewoznik` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nazwa_Przewoznika` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NIP` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Siedziba_adres` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ID_Przewoznik`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of przewoznik
-- ----------------------------

-- ----------------------------
-- Table structure for samolot
-- ----------------------------
DROP TABLE IF EXISTS `samolot`;
CREATE TABLE `samolot`  (
  `ID_Samolot` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nr_samolotu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Producent` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Ilosc_miejsc_klasa0` int(10) UNSIGNED NULL DEFAULT NULL,
  `Ilosc_miejsc_klasa1` int(10) NULL DEFAULT NULL,
  `Ilosc_miejsc_klasa2` int(10) NULL DEFAULT NULL,
  `Ladownosc` float UNSIGNED NOT NULL,
  `Data_produkcji` date NOT NULL,
  PRIMARY KEY (`ID_Samolot`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of samolot
-- ----------------------------

-- ----------------------------
-- Table structure for transakcja
-- ----------------------------
DROP TABLE IF EXISTS `transakcja`;
CREATE TABLE `transakcja`  (
  `ID_Transakcja` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Osoba` int(10) UNSIGNED NOT NULL,
  `ID_Lot` int(10) UNSIGNED NOT NULL,
  `Bagaz` int(10) UNSIGNED NOT NULL,
  `ID_Klasy` int(10) UNSIGNED NOT NULL,
  `Koszt` float UNSIGNED NOT NULL,
  `ID_Faktura` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Transakcja`) USING BTREE,
  INDEX `ID_Klasy`(`ID_Klasy`) USING BTREE,
  INDEX `ID_Lot`(`ID_Lot`) USING BTREE,
  INDEX `ID_Osoba`(`ID_Osoba`) USING BTREE,
  INDEX `ID_Faktura`(`ID_Faktura`) USING BTREE,
  CONSTRAINT `transakcja_ibfk_40` FOREIGN KEY (`ID_Faktura`) REFERENCES `faktura` (`ID_Faktura`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_5` FOREIGN KEY (`ID_Lot`) REFERENCES `lot` (`ID_Lot`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `transakcja_ibfk_6` FOREIGN KEY (`ID_Osoba`) REFERENCES `osoba` (`ID_Osoba`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transakcja
-- ----------------------------

-- ----------------------------
-- Table structure for typ_konta
-- ----------------------------
DROP TABLE IF EXISTS `typ_konta`;
CREATE TABLE `typ_konta`  (
  `ID_typ_konta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Typ_konta` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID_typ_konta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of typ_konta
-- ----------------------------

-- ----------------------------
-- View structure for vhistoria_transakcji
-- ----------------------------
DROP VIEW IF EXISTS `vhistoria_transakcji`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vhistoria_transakcji` AS SELECT
`transakcja`.`ID_Transakcja` AS `Numer_transakcji`,
`osoba`.`Imie` AS `Imię`,
`osoba`.`Nazwisko` AS `Nazwisko`,
(SELECT Nazwa_lotniska from lotnisko where ID_Lotnisko = lot.Lotnisko_start) as Lotnisko_początkowe,
(SELECT Nazwa_lotniska from lotnisko where ID_Lotnisko = lot.Lotnisko_koniec) as Lotnisko_końcowe,
`transakcja`.`Bagaz` AS `Bagaż`,
`transakcja`.`Koszt` AS `Koszt_podróży`
FROM
	(((
				`transakcja`
			JOIN `osoba` ON ( `transakcja`.`ID_Osoba` = `osoba`.`ID_Osoba` ))
	JOIN `lot` ON ( `transakcja`.`ID_Lot` = `lot`.`ID_Lot` ))) ;

-- ----------------------------
-- View structure for vopis_lotu
-- ----------------------------
DROP VIEW IF EXISTS `vopis_lotu`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vopis_lotu` AS SELECT
`lot`.`ID_Lot` AS `Numer_Lotu`,
(SELECT Nazwa_lotniska from lotnisko where ID_Lotnisko = lot.Lotnisko_start) as Lotnisko_początkowe,
(SELECT Nazwa_lotniska from lotnisko where ID_Lotnisko = lot.Lotnisko_koniec) as Lotnisko_końcowe,
`samolot`.`Producent` AS `Producent_samolotu`,
`samolot`.`Nr_samolotu` AS `Numer_samolotu`,
`lot`.`Dlugosc_lotu` AS `Długość_lotu`,
`przewoznik`.`Nazwa_Przewoznika` AS `Przewoźnik` 
FROM
	((
			`lot`
		JOIN `samolot` ON ( `lot`.`ID_Samolot` = `samolot`.`ID_Samolot` ))
	JOIN `przewoznik` ON ( `lot`.`ID_Przewoznik` = `przewoznik`.`ID_Przewoznik` )) ;

-- ----------------------------
-- Function structure for dodaj_blik
-- ----------------------------
DROP FUNCTION IF EXISTS `dodaj_blik`;
delimiter ;;
CREATE FUNCTION `dodaj_blik`()
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
                INSERT INTO platnosc(Typ_Platnosci) VALUES('Blik');
                
        INSERT INTO blik(ID_Platnosc) VALUES( (select MAX(pl.ID_Platnosc) from platnosc pl));
                
            RETURN 'Dodano blik';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_fakture
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_fakture`;
delimiter ;;
CREATE PROCEDURE `dodaj_fakture`(IN `v_brutto` FLOAT,
	IN `v_netto` FLOAT,
	IN `v_vat` INT,
	IN `v_nip` VARCHAR ( 30 ),
	IN `v_nazwa_przewoznika` VARCHAR ( 255 ))
BEGIN
	IF
		( v_brutto > 0.00 AND v_netto > 0.00 AND v_vat > 0 AND CHAR_LENGTH( v_nip )> 0 AND CHAR_LENGTH( v_nazwa_przewoznika )> 0 ) THEN
		
		START TRANSACTION;
		
			INSERT INTO faktura ( Brutto, Netto, VAT, NIP, ID_przewoznik )
		VALUES
			(
				`v_brutto`,
				`v_netto`,
				`v_vat`,
				`v_nip`,
			( SELECT p.ID_przewoznik FROM przewoznik p WHERE p.Nazwa_Przewoznika = v_nazwa_przewoznika ));
		
		COMMIT;
		
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for dodaj_karte
-- ----------------------------
DROP FUNCTION IF EXISTS `dodaj_karte`;
delimiter ;;
CREATE FUNCTION `dodaj_karte`(`v_nr_karty` varchar(20), `v_cvv` varchar(3), `v_data_wygasniecia` date)
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
                INSERT INTO platnosc(Typ_Platnosci) VALUES('Karta');
                
        INSERT INTO karta(ID_Platnosc, Nr_Karty, CVV, Data_wygasniecia) VALUES( (select MAX(pl.ID_Platnosc) from platnosc pl), v_nr_karty, v_cvv, v_data_wygasniecia);
                
            RETURN 'Dodano karte';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_lot
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_lot`;
delimiter ;;
CREATE PROCEDURE `dodaj_lot`(IN `v_lotnisko_start` VARCHAR(255),IN `v_lotnisko_koniec` VARCHAR(255),IN `v_data_godzina_start` datetime,IN `v_data_godzina_koniec` datetime,IN `v_typ_lotu` enum('Krajowy', 'Strefa_schengen', 'Non_schengen'),IN `v_nr_samolotu` varchar(25),IN `v_nazwa_przewoznika` varchar(255))
BEGIN
    
    IF (CHAR_LENGTH(v_lotnisko_start)>0 AND CHAR_LENGTH(v_lotnisko_koniec)>0 AND CHAR_LENGTH(v_nr_samolotu)>0 AND CHAR_LENGTH(v_nazwa_przewoznika)) THEN
		
		START TRANSACTION;
        
        INSERT INTO lot(Lotnisko_start, Lotnisko_koniec, ID_samolot, ID_przewoznik, Data_godzina_start, Data_godzina_koniec, Dostepna_ladownosc, Typ_lotu, Ilosc_wolnych_miejsc_klasa0, Ilosc_wolnych_miejsc_klasa1, Ilosc_wolnych_miejsc_klasa2, Dlugosc_lotu) 
        VALUES(
        (select l.ID_Lotnisko from lotnisko l WHERE l.Nazwa_lotniska = v_lotnisko_start), 
        (select l.ID_Lotnisko from lotnisko l WHERE l.Nazwa_lotniska = v_lotnisko_koniec),
        (select s.ID_samolot from samolot s WHERE s.nr_samolotu = v_nr_samolotu),
        (select p.ID_przewoznik from przewoznik p WHERE p.Nazwa_Przewoznika = v_nazwa_przewoznika),
        `v_data_godzina_start`, 
        `v_data_godzina_koniec`,
        (select samolot.Ladownosc from samolot where ID_Samolot = samolot.ID_Samolot),
				`v_typ_lotu`,
				(select samolot.Ilosc_miejsc_klasa0 from samolot where ID_Samolot = samolot.ID_Samolot),
				(select samolot.Ilosc_miejsc_klasa1 from samolot where ID_Samolot = samolot.ID_Samolot),
				(select samolot.Ilosc_miejsc_klasa2 from samolot where ID_Samolot = samolot.ID_Samolot),
				(TIMEDIFF(v_data_godzina_koniec,v_data_godzina_start))
				);
			COMMIT;
        
    END IF;
 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_lotnisko
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_lotnisko`;
delimiter ;;
CREATE PROCEDURE `dodaj_lotnisko`(IN `v_nazwa_lotniska` varchar(255),IN `v_kraj` varchar(50),IN `v_miasto` varchar(50),IN  `v_strefa_czasowa` int(11))
BEGIN
    
    IF (CHAR_LENGTH(v_nazwa_lotniska)>0 AND CHAR_LENGTH(v_kraj)>0 AND CHAR_LENGTH(v_miasto)) THEN
        
				START TRANSACTION;
				
        INSERT INTO lotnisko(Nazwa_lotniska, Kraj, Miasto, Strefa_czasowa) VALUES(`v_nazwa_lotniska`, `v_kraj`, `v_miasto` , `v_strefa_czasowa`);
				
				COMMIT;
        
    END IF;
 
 
END
;;
delimiter ;

-- ----------------------------
-- Function structure for dodaj_przelew
-- ----------------------------
DROP FUNCTION IF EXISTS `dodaj_przelew`;
delimiter ;;
CREATE FUNCTION `dodaj_przelew`(`v_nazwa_przelewu` varchar(255),`v_numer_konta` varchar(30))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
        if(char_length(v_nazwa_przelewu) >0 and char_length(v_numer_konta) >0 ) 
        then
        
                INSERT INTO platnosc(Typ_Platnosci) VALUES('Przelew');
                
        INSERT INTO przelew(ID_Platnosc, Nazwa_przelewu, Nr_Konta) VALUES( (select MAX(pl.ID_Platnosc) from platnosc pl),v_nazwa_przelewu,v_numer_konta);
                
            RETURN 'Dodano przelew';
        end if;
        RETURN 'Niewlasciwe dane: ';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_przewoznika
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_przewoznika`;
delimiter ;;
CREATE PROCEDURE `dodaj_przewoznika`(IN `v_nazwa` varchar(255),IN `v_NIP` varchar(30),IN `v_siedziba` varchar(255))
BEGIN
    
    IF (CHAR_LENGTH(v_nazwa)>0 AND CHAR_LENGTH(v_NIP)>0 AND CHAR_LENGTH(v_siedziba)>0) THEN
        
				START TRANSACTION;
        INSERT INTO przewoznik(Nazwa_Przewoznika, NIP, Siedziba_adres) VALUES(`v_nazwa`, `v_NIP`, `v_siedziba`);
        COMMIT;
    END IF;
 
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_samolot
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_samolot`;
delimiter ;;
CREATE PROCEDURE `dodaj_samolot`(IN `v_nr_samolotu` varchar(25),IN `v_producent` varchar(255),IN `v_data_produkcji` date, IN `v_ladownosc` FLOAT, IN `v_ilosc_miejsc_klasa0` INT, `v_ilosc_miejsc_klasa1` INT, `v_ilosc_miejsc_klasa2` INT)
BEGIN
    
    IF (CHAR_LENGTH(v_nr_samolotu)>0 AND CHAR_LENGTH(v_producent)>0 AND dayname(cast(v_data_produkcji as char)) is NOT NULL AND v_ladownosc>0 and v_ilosc_miejsc_klasa0 >= 0 and v_ilosc_miejsc_klasa1 >= 0 and v_ilosc_miejsc_klasa2 >= 0) THEN
		START TRANSACTION;
    INSERT INTO samolot(Nr_samolotu, Producent, Data_produkcji, Ladownosc, Ilosc_miejsc_klasa0, Ilosc_miejsc_klasa1, Ilosc_miejsc_klasa2) VALUES(`v_nr_samolotu`, `v_producent`, `v_data_produkcji` , `v_ladownosc`, `v_ilosc_miejsc_klasa0`, `v_ilosc_miejsc_klasa1` , `v_ilosc_miejsc_klasa2`);
		COMMIT;
END IF;
 
 
END
;;
delimiter ;

-- ----------------------------
-- Function structure for dodaj_transakcje
-- ----------------------------
DROP FUNCTION IF EXISTS `dodaj_transakcje`;
delimiter ;;
CREATE FUNCTION `dodaj_transakcje`(v_login varchar(25), v_lotnisko_start varchar(255), v_lotnisko_koniec varchar(255), v_data_godzina_start datetime, v_data_godzina_koniec datetime, v_bagaz int(10),v_ID_klasy int(10))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
        if(char_length(v_login) >0 and v_bagaz>0  and v_ID_klasy>=0 and v_ID_klasy<3 ) 
        then


                IF v_bagaz=0 THEN
                    set @koszt_bagazu = 0;
                ELSE
                    IF v_bagaz<=15 THEN
                        set @koszt_bagazu = 50;
                    ELSE
                        IF v_bagaz<=40 THEN
                            set @koszt_bagazu = 100;
                        ELSE
                            IF v_bagaz<=80 THEN
                                set @koszt_bagazu = 200;
                            ELSE
                                IF v_bagaz<=100 THEN
                                    set @koszt_bagazu = 400;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                END IF;

                set @idlotu = (select szukaj_polaczenia(v_lotnisko_start,v_lotnisko_koniec, v_data_godzina_start, v_data_godzina_koniec ));
 

        INSERT INTO transakcja(ID_Osoba, ID_Lot, Bagaz, ID_Klasy, Koszt) 
                VALUES(
                (select o.ID_Osoba from osoba o where o.Login=v_login),
                @idlotu,
                v_bagaz,v_ID_klasy,
                40 * (v_ID_klasy+1) + @koszt_bagazu 
								);

            RETURN 'Dodano transakcje';
        end if;
        RETURN 'Niewlasciwe dane: ';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_typ_platnosci
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_typ_platnosci`;
delimiter ;;
CREATE PROCEDURE `dodaj_typ_platnosci`(IN `v_typ_platnosci` varchar(20))
BEGIN
    
    if(CHAR_LENGTH(v_typ_platnosci)>0)THEN
		START TRANSACTION;
        INSERT INTO platnosc(Typ_Platnosci) VALUES(`v_typ_platnosci`);
				COMMIT;
    END IF;
 
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_fakture
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_fakture`;
delimiter ;;
CREATE FUNCTION `modyfikuj_fakture`(`v_id_faktura` int(10), `v_nowe_brutto` float,`v_nowe_netto` float,`v_nowy_vat` int,`v_nowy_nip` varchar(30),`v_nowa_nazwa_przewoznika` varchar(255))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(v_id_faktura >0) 
    then
        if(EXISTS(select f.ID_Faktura from faktura f where f.ID_Faktura = `v_id_faktura`))
        then
        
            UPDATE faktura f SET Brutto=v_nowe_brutto, Netto=v_nowe_netto, VAT=v_nowy_vat, NIP=v_nowy_nip, ID_przewoznik=(select p.ID_przewoznik from przewoznik p where p.Nazwa_Przewoznika = v_nowa_nazwa_przewoznika) WHERE f.ID_Faktura=`v_id_faktura`;
            RETURN 'Pomyslnie zmodyfikowano fakture';
        
        end if;
    RETURN 'Taka faktura nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_lot
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_lot`;
delimiter ;;
CREATE FUNCTION `modyfikuj_lot`(`v_ID_Lot` int(10), `v_nowe_lotnisko_start` VARCHAR(255), `v_nowe_lotnisko_koniec` VARCHAR(255), `v_nowa_data_godzina_start` datetime, `v_nowa_data_godzina_koniec` datetime, `v_nowa_dlugosc_lotu` float, `v_nowy_typ_lotu` enum('Krajowy', 'Strefa_schengen', 'Non_schengen'), `v_nowy_nr_samolotu` varchar(25), `v_nowa_nazwa_przewoznika` varchar(255))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(v_ID_Lot >0) 
    then
        if(EXISTS(select l.ID_Lot from lot l where l.ID_Lot = `v_ID_Lot`))
        then
        
            UPDATE lot l SET 
            Lotnisko_start=(select l.ID_Lotnisko from lotnisko l WHERE l.Nazwa_lotniska = v_nowe_lotnisko_start), 
            Lotnisko_koniec=(select l.ID_Lotnisko from lotnisko l WHERE l.Nazwa_lotniska = v_nowe_lotnisko_koniec), 
            ID_samolot=(select s.ID_samolot from samolot s WHERE s.nr_samolotu = v_nr_samolotu), 
            ID_przewoznik=(select p.ID_przewoznik from przewoznik p WHERE p.Nazwa_Przewoznika = v_nazwa_przewoznika), 
            Data_godzina_start=v_nowa_data_godzina_start, 
            Data_godzina_koniec=v_nowa_data_godzina_koniec, 
            Dlugosc_lotu=v_nowa_dlugosc_lotu, 
            Typ_lotu=v_nowy_typ_lotu  WHERE l.ID_Lot=`v_ID_Lot`;
            RETURN 'Pomyslnie zmodyfikowano lot';
            
        end if;
    RETURN 'Taki lot nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_lotnisko
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_lotnisko`;
delimiter ;;
CREATE FUNCTION `modyfikuj_lotnisko`(`v_nazwa_lotniska` varchar(255), `v_nowa_nazwa_lotniska` varchar(255), `v_nowy_kraj` varchar(50), `v_nowe_miasto` varchar(50),  `v_nowa_strefa_czasowa` int(11))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(char_length(v_nazwa_lotniska) >0) 
    then
        if(EXISTS(select l.Nazwa_lotniska from lotnisko l where l.Nazwa_lotniska = `v_nazwa_lotniska`))
        then
        
            UPDATE lotnisko l SET Nazwa_lotniska=v_nowa_nazwa_lotniska, Kraj=v_nowy_kraj, Miasto=v_nowe_miasto, Strefa_czasowa=v_nowa_strefa_czasowa WHERE l.Nazwa_lotniska=`v_nazwa_lotniska`;
            RETURN 'Pomyslnie zmodyfikowano lotnisko';
        
        
        end if;
    RETURN 'Takie lotnisko nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_osobe
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_osobe`;
delimiter ;;
CREATE FUNCTION `modyfikuj_osobe`(`v_login` varchar(25),`v_haslo` varchar(35), `typ` enum('Imie', 'Nazwisko', 'Mail', 'Telefon', 'Haslo'), `v_do_zmiany` varchar(100))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(char_length(v_login) >0 and char_length(v_haslo) >0) 
    then
        if(EXISTS(select o.Login from osoba o where o.Login = `v_login` AND o.Haslo=`v_haslo`))
        then
        
        
            CASE `typ`
            WHEN 'Imie' and (char_length(v_do_zmiany) <= 20) THEN
                UPDATE osoba o SET Imie=`v_do_zmiany` WHERE o.Login=`v_login`;
            WHEN 'Nazwisko' and char_length(v_do_zmiany) <= 30 THEN
                UPDATE osoba o SET Nazwisko=`v_do_zmiany` WHERE o.Login=`v_login`;
            WHEN 'Mail' and char_length(v_do_zmiany) <= 100 THEN
                UPDATE osoba o SET Mail=`v_do_zmiany` WHERE o.Login=`v_login`;
            WHEN 'Telefon' and char_length(v_do_zmiany) <= 20 THEN
                UPDATE osoba o SET Telefon=`v_do_zmiany` WHERE o.Login=`v_login`;
            WHEN 'Haslo' and char_length(v_do_zmiany) <= 35 THEN
                UPDATE osoba o SET Haslo=`v_do_zmiany` WHERE o.Login=`v_login`;
            ELSE
                RETURN 'Niewlasciwe dane!';
            END CASE;
 
        end if;
    RETURN 'Taki uzytkownik nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_przewoznika
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_przewoznika`;
delimiter ;;
CREATE FUNCTION `modyfikuj_przewoznika`(`v_nazwa` varchar(255),`v_nowa_nazwa` varchar(255), `v_nowy_NIP` varchar(20), `v_nowa_siedziba` varchar(255))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(CHAR_LENGTH(v_nazwa) >0) 
    then
        if(EXISTS(select p.Nazwa_Przewoznika from przewoznik p where p.Nazwa_Przewoznika = `v_nazwa`))
        then
        
            UPDATE przewoznik p SET Nazwa_Przewoznika=v_nowa_nazwa, NIP=v_nowy_NIP, Siedziba_adres=v_nowa_siedziba WHERE p.Nazwa_Przewoznika=`v_nazwa`;
            RETURN 'Pomyslnie zmodyfikowano przewoznika';
 
        end if;
    RETURN 'Taki przewoznik nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for modyfikuj_samolot
-- ----------------------------
DROP FUNCTION IF EXISTS `modyfikuj_samolot`;
delimiter ;;
CREATE FUNCTION `modyfikuj_samolot`(`v_nr_samolotu` varchar(1000), `v_nowy_nr_samolotu` varchar(1000), `v_nowy_producent` varchar(30), `v_nowa_data_produkcji` date, `v_nowa_ladownosc` int(10))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(char_length(v_nr_samolotu) >0) 
    then
        if(EXISTS(select s.Nr_samolotu from samolot s where s.Nr_samolotu = `v_nr_samolotu`))
        then
        
            UPDATE samolot s SET Nr_samolotu=v_nowy_nr_samolotu, Producent=v_nowy_producent, Data_produkcji=v_nowa_data_produkcji, Ladownosc=v_nowa_ladownosc WHERE s.Nr_samolotu=`v_nr_samolotu`;
            RETURN 'Pomyslnie zmodyfikowano samolot';
        
        
        end if;
    RETURN 'Taki samolot nie istnieje';
    end if;
        RETURN 'Niewlasciwe dane! ';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for szukaj_polaczenia
-- ----------------------------
DROP FUNCTION IF EXISTS `szukaj_polaczenia`;
delimiter ;;
CREATE FUNCTION `szukaj_polaczenia`(v_lotnisko_start varchar(255),v_lotnisko_koniec varchar(255), v_data_godzina_start datetime, v_data_godzina_koniec datetime)
 RETURNS int(10)
BEGIN
    if(EXISTS(select lot.ID_lot from lot where lot.Lotnisko_start = (select ID_lotnisko from lotnisko where lotnisko.Nazwa_lotniska=v_lotnisko_start) and lot.Lotnisko_koniec = (select ID_lotnisko from lotnisko where lotnisko.Nazwa_lotniska=v_lotnisko_koniec) and DAY(lot.Data_godzina_start) = DAY(v_data_godzina_start) and  DAY(lot.Data_godzina_koniec) = DAY(v_data_godzina_koniec) ORDER BY lot.Dlugosc_lotu LIMIT 1))
    THEN
    return (select lot.ID_lot from lot where lot.Lotnisko_start = (select ID_lotnisko from lotnisko where lotnisko.Nazwa_lotniska=v_lotnisko_start) and lot.Lotnisko_koniec = (select ID_lotnisko from lotnisko where lotnisko.Nazwa_lotniska=v_lotnisko_koniec) and DAY(lot.Data_godzina_start) = DAY(v_data_godzina_start) and  DAY(lot.Data_godzina_koniec) = DAY(v_data_godzina_koniec) ORDER BY lot.Dlugosc_lotu LIMIT 1);
    end if;
 
    RETURN 0;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for wypisz_info_o_locie
-- ----------------------------
DROP PROCEDURE IF EXISTS `wypisz_info_o_locie`;
delimiter ;;
CREATE PROCEDURE `wypisz_info_o_locie`(IN `v_id_lot` int(10))
BEGIN
    select * from lot l where l.ID_Lot = v_id_lot;
 
END
;;
delimiter ;

-- ----------------------------
-- Function structure for zarejestruj_uzytkownika
-- ----------------------------
DROP FUNCTION IF EXISTS `zarejestruj_uzytkownika`;
delimiter ;;
CREATE FUNCTION `zarejestruj_uzytkownika`(`v_imie` varchar(20),`v_nazwisko` varchar(30), `v_pesel` VARCHAR(15) ,`v_nr_telefonu` varchar(20), `v_mail` varchar(100), `v_plec` enum('Kobieta', 'Mezczyzna', 'Inne'), `v_nr_dowodu_paszportu` VARCHAR(10), `typ_osoby` enum('Uzytkownik', 'Administrator', 'Pracownik'), `v_haslo` varchar(35))
 RETURNS varchar(64) CHARSET utf8mb4
BEGIN
    if(not EXISTS(select * from osoba where osoba.pesel = `v_pesel`))
    then
        if(char_length(v_imie) >0 and char_length(v_nazwisko) >0  and `v_pesel`> 0 and char_length(`v_nr_telefonu`) > 0 and CHAR_LENGTH(`v_nr_dowodu_paszportu`)>0 and CHAR_LENGTH(`v_mail`) > 0 and CHAR_LENGTH(`v_haslo`)>0) 
        then
        
        INSERT INTO osoba( Imie, Nazwisko, Pesel, Nr_telefonu, Mail, Plec, `Nr_dowodu/paszportu`, Typ, Haslo, Login) VALUES(`v_imie`,`v_nazwisko`, `v_pesel`, `v_nr_telefonu`, `v_mail`, `v_plec`, `v_nr_dowodu_paszportu`, `typ_osoby`, `v_haslo`, `v_mail`);
                
            RETURN concat('Twoj wygenerowany login: ', `v_mail`);
        end if;
        RETURN 'Niewlasciwe dane: ';
    end if;
    RETURN 'Taki uzytkownik juz istnieje';
END
;;
delimiter ;

-- ----------------------------
-- Event structure for nowa_partycja
-- ----------------------------
DROP EVENT IF EXISTS `nowa_partycja`;
delimiter ;;
CREATE EVENT `nowa_partycja`
ON SCHEDULE
EVERY '1' YEAR STARTS '2023-12-25 02:00:00'
ON COMPLETION PRESERVE
DO begin
set @nowy_rok = year(now())+1;
set @sql =concat("alter table faktura reorganize partition wieksze_od_", year(now())," into ( partition mniejsze_od_",@nowy_rok,"values less than (",(@nowy_rok+1),"), partition wieksze_od_", @nowy_rok, " values less than maxvalue);");
prepare st1 from @sql;
execute st1;
deallocate prepare st1;
end
;;
delimiter ;

-- ----------------------------
-- Event structure for usun_stare_faktury
-- ----------------------------
DROP EVENT IF EXISTS `usun_stare_faktury`;
delimiter ;;
CREATE EVENT `usun_stare_faktury`
ON SCHEDULE
EVERY '1' YEAR STARTS '2022-06-14 22:45:03'
ON COMPLETION PRESERVE
DO delete FROM faktura where datediff(now(), faktura.Data_faktury) >(365*5)
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table karta
-- ----------------------------
DROP TRIGGER IF EXISTS `kontrola_nr_karty`;
delimiter ;;
CREATE TRIGGER `kontrola_nr_karty` AFTER INSERT ON `karta` FOR EACH ROW BEGIN
		IF (CHAR_LENGTH(NEW.Nr_Karty) != 16) THEN
			SIGNAL SQLSTATE '45000'
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Niepoprawny numer karty!';
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table karta
-- ----------------------------
DROP TRIGGER IF EXISTS `kontrola_cvv`;
delimiter ;;
CREATE TRIGGER `kontrola_cvv` AFTER INSERT ON `karta` FOR EACH ROW BEGIN
		IF (CHAR_LENGTH(NEW.CVV) != 3) THEN
			SIGNAL SQLSTATE '45000'
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Niepoprawny numer CVV!';
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table osoba
-- ----------------------------
DROP TRIGGER IF EXISTS `kontrola_pesel`;
delimiter ;;
CREATE TRIGGER `kontrola_pesel` AFTER INSERT ON `osoba` FOR EACH ROW BEGIN
		IF (CHAR_LENGTH(NEW.Pesel) != 11) THEN
			SIGNAL SQLSTATE '45000'
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Niepoprawny numer PESEL!';
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table osoba
-- ----------------------------
DROP TRIGGER IF EXISTS `kontrola_mail`;
delimiter ;;
CREATE TRIGGER `kontrola_mail` AFTER INSERT ON `osoba` FOR EACH ROW BEGIN
		IF (NEW.Mail NOT LIKE '%@%.%') THEN
			SIGNAL SQLSTATE '45000'
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Niepoprawny Mail!';
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table przelew
-- ----------------------------
DROP TRIGGER IF EXISTS `kontrola_nr_konta`;
delimiter ;;
CREATE TRIGGER `kontrola_nr_konta` AFTER INSERT ON `przelew` FOR EACH ROW BEGIN
		IF (CHAR_LENGTH(NEW.Nr_konta) != 26) THEN
			SIGNAL SQLSTATE '45000'
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Niepoprawny numer konta!';
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transakcja
-- ----------------------------
DROP TRIGGER IF EXISTS `ladownosc_bagazu`;
delimiter ;;
CREATE TRIGGER `ladownosc_bagazu` AFTER INSERT ON `transakcja` FOR EACH ROW BEGIN
        UPDATE lot SET lot.dostepna_ladownosc = lot.dostepna_ladownosc - NEW.Bagaz;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transakcja
-- ----------------------------
DROP TRIGGER IF EXISTS `ograniczenie_bagazu`;
delimiter ;;
CREATE TRIGGER `ograniczenie_bagazu` AFTER INSERT ON `transakcja` FOR EACH ROW BEGIN
	IF
		( NEW.Bagaz > 100 ) THEN
			SIGNAL SQLSTATE '45000' 
			SET MYSQL_ERRNO = 30001,
			MESSAGE_TEXT = 'Wybrana masa bagażu jest zbyt duża!';
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transakcja
-- ----------------------------
DROP TRIGGER IF EXISTS `liczba_miejsc`;
delimiter ;;
CREATE TRIGGER `liczba_miejsc` AFTER INSERT ON `transakcja` FOR EACH ROW BEGIN
        IF NEW.ID_klasy = 0 THEN
                UPDATE lot SET lot.Ilosc_wolnych_miejsc_klasa0 = lot.Ilosc_wolnych_miejsc_klasa0 - 1;
        ELSEIF NEW.ID_klasy = 1 THEN
                UPDATE lot SET lot.Ilosc_wolnych_miejsc_klasa1 = lot.Ilosc_wolnych_miejsc_klasa1 - 1;
        ELSE
                UPDATE samolot SET lot.Ilosc_wolnych_miejsc_klasa2 = lot.Ilosc_wolnych_miejsc_klasa2 - 1;
        END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
