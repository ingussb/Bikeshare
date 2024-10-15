--Removing nulls: 

CREATE TABLE clean_data AS (SELECT * FROM combined_data_23_24
WHERE start_station_name IS NOT NULL 
AND start_station_id IS NOT NULL 
AND start_station_id IS NOT NULL 
AND end_station_name IS NOT NULL
AND end_station_id IS NOT NULL
AND end_lat IS NOT NULL
AND end_lng IS NOT NULL)

--After removal, 4075313 rows left, so 1383512 rows removed

--Setting ride_id as primary key

ALTER TABLE clean_data
ADD PRIMARY KEY (ride_id) 


--Adding more data: reformatting timestamp, calculated time difference between ended_at and started_at removed trips lesser than 1 min and more than 24h, created a view as filtered_data for analysis



CREATE OR REPLACE VIEW filtered_data AS (
    SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, 
        CASE 
            WHEN EXTRACT(DOW FROM started_at) = 1 THEN 'SUN'
            WHEN EXTRACT(DOW FROM started_at) = 2 THEN 'MON'
            WHEN EXTRACT(DOW FROM started_at) = 3 THEN 'TUE'
            WHEN EXTRACT(DOW FROM started_at) = 4 THEN 'WED'
            WHEN EXTRACT(DOW FROM started_at) = 5 THEN 'THU'
            WHEN EXTRACT(DOW FROM started_at) = 6 THEN 'FRI'
            ELSE 'SAT'
        END AS day_of_week,
        
        CASE 
            WHEN EXTRACT(MONTH FROM started_at) = 1 THEN 'JAN'
            WHEN EXTRACT(MONTH FROM started_at) = 2 THEN 'FEB'
            WHEN EXTRACT(MONTH FROM started_at) = 3 THEN 'MAR'
            WHEN EXTRACT(MONTH FROM started_at) = 4 THEN 'APR'
            WHEN EXTRACT(MONTH FROM started_at) = 5 THEN 'MAY'
            WHEN EXTRACT(MONTH FROM started_at) = 6 THEN 'JUN'
            WHEN EXTRACT(MONTH FROM started_at) = 7 THEN 'JUL'
            WHEN EXTRACT(MONTH FROM started_at) = 8 THEN 'AUG'
            WHEN EXTRACT(MONTH FROM started_at) = 9 THEN 'SEP'
            WHEN EXTRACT(MONTH FROM started_at) = 10 THEN 'OCT'
            WHEN EXTRACT(MONTH FROM started_at) = 11 THEN 'NOV'
            ELSE 'DEC'
        END AS month,
        
        EXTRACT(DAY FROM started_at) AS day,
        EXTRACT(YEAR FROM started_at) AS year,
        FLOOR(EXTRACT(EPOCH FROM AGE(ended_at, started_at)) / 60) AS trip_length_m
        
    FROM clean_data
    WHERE 
        FLOOR(EXTRACT(EPOCH FROM AGE(ended_at, started_at)) / 60) >= 1
        AND FLOOR(EXTRACT(EPOCH FROM AGE(ended_at, started_at)) / 60) <= 1440
);
