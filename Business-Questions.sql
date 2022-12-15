SELECT * FROM air_pollution.tb_air_quality;

# 1- Which pollutants were considered in the research?
SELECT DISTINCT(pollutant) FROM air_pollution.tb_air_quality;

# 2- What was the average pollution over time caused by the ground-level pollutant ozone (o3)?
SELECT 
	country,
	CAST(timestamp AS DATE) date,
    ROUND(AVG(CAST(value AS UNSIGNED)) OVER(PARTITION BY country ORDER BY CAST(timestamp AS DATE)),2) avg_pollution
FROM air_pollution.tb_air_quality
WHERE pollutant = 'o3'
ORDER BY country, date;

# 3- What was the average pollution caused by the ground-level pollutant ozone (o3) per country measured in µg/m³ (micrograms per cubic meter)?SELECT country, 
       ROUND(AVG(value),2) avg_pollution
FROM air_pollution.tb_air_quality
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
GROUP BY country
ORDER BY avg_pollution ASC;

# 4- Considering the previous result, which country had a higher overall o3 pollution index, Italy (IT) or Spain (ES)? Because?
SELECT country, 
       ROUND(AVG(value),2) AS avg_pollution, 
       STDDEV(value) AS standard_deviation, 
       MAX(value) AS max, 
       MIN(value) AS min
FROM air_pollution.tb_air_quality
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
AND country IN ('IT', 'ES') 
GROUP BY country
ORDER BY avg_pollution ASC;

# The Coefficient of Variation (CV) is a statistical measure of the dispersion of data in a data series around the mean.
# The Coefficient of Variation represents the ratio between the standard deviation and the mean and is a useful statistic for comparing the degree
# of variation from one data series to another, even if the means are drastically different from each other.

# The greater the Coefficient of Variation, the greater the level of dispersion around the mean, therefore, the greater variability.

# The Coefficient of Variation is calculated as follows: CV = (Standard Deviation / Mean) * 100
SELECT country, 
       ROUND(AVG(value),2) AS avg_pollution, 
       STDDEV(value) AS standard_deviation, 
       MAX(value) AS max, 
       MIN(value) AS min,
       (STDDEV(value) / ROUND(AVG(value),2)) * 100 AS cv
FROM air_pollution.tb_air_quality
WHERE pollutant = 'o3'
AND unit = 'µg/m³'
AND country IN ('IT', 'ES') 
GROUP BY country
ORDER BY avg_pollution ASC;

# Conclusion: Although the CV for Spain is much higher, the average for Italy is very high, with data points closer to the average.
# Both countries have a high rate of general o3 pollution
# Italy has a higher overall pollution rate because the average is high and the data points are closer to the average.

# 5- Which locations and countries had an average pollution in 2020 greater than 100 µg/m³ for the pollutant fine particulate matter (pm25)?
SELECT COALESCE(location, "Total") AS location,
	COALESCE(country, "Total") AS country, 
	ROUND(AVG(value), 2) AS avg_pollution
FROM air_pollution.tb_air_quality
WHERE pollutant = 'pm25'
AND YEAR(timestamp) = 2020
GROUP BY location, country WITH ROLLUP
HAVING avg_pollution > 100
ORDER BY location, country;