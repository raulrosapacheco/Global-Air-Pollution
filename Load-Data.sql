# Loading Data

CREATE SCHEMA `air_pollution`;

CREATE TABLE air_pollution.tb_air_quality (
  `location` text,
  `city` text,
  `country` text,
  `pollutant` text,
  `value` text,
  `timestamp` text,
  `unit` text,
  `source_name` text,
  `latitude` text,
  `longitude` text,
  `averaged_over_in_hours` text);
  
# Loading data via command line

# cd 'C:\Program Files\MySQL\MySQL Server 8.0\bin'
# .\mysql.exe --local-infile=1 -u root -p
# SET GLOBAL local_infile = true;
# LOAD DATA LOCAL INFILE 'D:/SQL-DS-rr/09-Analise-Dados/Desafio/dados/dataset.csv' INTO TABLE `air_pollution`.`tb_air_quality` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' ENCLOSED BY "" IGNORE 1 LINES;

