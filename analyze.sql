--How many members vs customers: 

SELECT  member_casual, COUNT(member_casual) from filtered_data
GROUP BY(member_casual)

	
	
--Top 10 start_stations for members&casuals:



SELECT  COUNT (member_casual) As casual_count, start_station_name from filtered_data
WHERE member_casual = 'casual'
GROUP BY(member_casual, start_station_name)
ORDER BY COUNT(member_casual) DESC
LIMIT 10

--Top 10 end_stations for members&casuals:


SELECT  COUNT (member_casual) As casual_count, end_station_name from filtered_data
WHERE member_casual = 'casual'
GROUP BY(member_casual, end_station_name)
ORDER BY COUNT(member_casual) DESC
LIMIT 10

--Riding tendencies by DOW:

SELECT COUNT(day_of_week) as ride_count, day_of_week, member_casual from filtered_data
GROUP BY (day_of_week, member_casual)
ORDER by ride_count DESC


--Top choice per bike type:

SELECT COUNT (rideable_type) AS count, rideable_type, member_casual FROM filtered_data
GROUP BY (rideable_type, member_casual)
ORDER BY count DESC


--AVG trip length:


SELECT AVG (trip_length_m) avg_length, member_casual FROM filtered_data
GROUP BY (member_casual)
ORDER BY (avg_length) DESC


--AVG trip length per month:

SELECT AVG (trip_length_m) avg_length, month, member_casual FROM filtered_data
GROUP BY (member_casual, filtered_data.month)
ORDER BY (month) DESC



--Most active month:

SELECT COUNT(ride_id) rides, month, member_casual FROM filtered_data
GROUP BY (month, member_casual)
ORDER BY (rides) DESC

--Discovered an issue - majority of NULLS occurred during May 2023 therefore after the NULL drop, May returns only 121 ride. Dropping May completely.

DELETE FROM  filtered_data
WHERE MONTH = 'MAY'

