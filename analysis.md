#  Analysis

Analyzing membership trends reveals distinct patterns between casual users and members regarding usage.

## Issues

While working on visualisations, discovered some anomality - May was returning only 121 rides in total, while other months - 100k rides. Checked NULL values in May  (original data source) and discovered that a lot of NULL values occured in May (star_station_name, end_station name). Therefore, majority of data was removed during data cleaning. Decided to drop May altogether.

```sql
DELETE FROM  filtered_data
WHERE MONTH = 'MAY'
```


## How many members vs casuals: 

 ```sql
SELECT  member_casual, COUNT(member_casual) from filtered_data
GROUP BY(member_casual)
```

<img width="308" alt="member_casual" src="https://github.com/user-attachments/assets/25dde7ca-908a-401a-9bb0-57ab3cd388c6">

## Top 10 start_stations for casual users:

```sql
SELECT  COUNT (member_casual), start_station_name from filtered_data
WHERE member_casual = 'casual'
GROUP BY(start_station_name)
ORDER BY COUNT(member_casual) DESC
LIMIT 10
```

<img width="334" alt="Screenshot 2024-10-16 at 21 28 38" src="https://github.com/user-attachments/assets/78b2cd77-969a-44fb-982c-f7348c1fa80b">


## Top 10 end_stations for casual users:

```sql
SELECT  COUNT (member_casual), end_station_name from filtered_data
WHERE member_casual = 'casual'
GROUP BY(end_station_name)
ORDER BY COUNT(member_casual) DESC
LIMIT 10
```

<img width="335" alt="Screenshot 2024-10-16 at 21 30 06" src="https://github.com/user-attachments/assets/ee8d6416-260b-449b-8036-8edd9c16e60b">

## Top choice per bike type:

```sql
SELECT COUNT (rideable_type) AS count, rideable_type, member_casual FROM filtered_data
GROUP BY (rideable_type, member_casual)
ORDER BY count DESC
```

<img width="443" alt="rideable_type" src="https://github.com/user-attachments/assets/cb544418-fb87-4e76-a574-928e6c22b53f">

The high usage of electric bikes among both member and casual users suggests a preference for the convenience and speed they offer, especially for longer trips. Classic bikes remain a staple.

## Riding tendencies by DOW:

```sql
SELECT COUNT(day_of_week) as ride_count, day_of_week, member_casual from filtered_data
GROUP BY (day_of_week, member_casual)
ORDER by ride_count DESC
```

![DOW_trend](https://github.com/user-attachments/assets/0535fa23-7751-4ee8-bec0-fe026a270dca)

Member usage aligns with a weekday commuting pattern, while casual users are more active on weekends, likely for leisure purposes.

## AVG trip length:

```sql
SELECT AVG (trip_length_m) avg_length, member_casual FROM filtered_data
GROUP BY (member_casual)
ORDER BY (avg_length) DESC
```

<img width="383" alt="AVG_ride_length" src="https://github.com/user-attachments/assets/2d26febf-203e-436c-8ecd-3c3fb37e8284">

Casuals take double the longer trips, meaning weekend leisure trips vs members - to work/other quick rides

## AVG trip length per month:

```sql
SELECT AVG (trip_length_m) avg_length, month, member_casual FROM filtered_data
GROUP BY (member_casual, filtered_data.month)
ORDER BY (month) DESC
```

![AVG_trip_l_mon](https://github.com/user-attachments/assets/64f648c2-1e2d-4346-be43-6613da4d63ba)

Casual users consistently have longer average trip durations compared to members, with the highest trip length seen during the summer months (June, July, and August). This aligns with expected patterns where warm-weather months see more recreational use, particularly from casual riders.

## Most active month:



```sql
SELECT COUNT(ride_id) rides, month, member_casual FROM filtered_data
GROUP BY (month, member_casual)
ORDER BY (rides) DESC
```

![month_activity](https://github.com/user-attachments/assets/33836ca4-23e9-4ec3-97c5-b4f5bd5d8978)

The data indicates that summer is the most active season for rides, with July being the peak month. Casual users are more seasonal in their usage, heavily favoring the summer months, while members maintain more steady activity across the year.

# Strategies for Converting Casual Riders to Annual Memberships



## 1. Offer Seasonal Membership Discounts for Casual Users
Since casual users are more active during summer, a time-limited discount for membership that starts just before summer could be enticing. This could take the form of a "Summer Pass" or a discounted annual membership for those who subscribe during the peak summer months. Highlight the benefits of membership, such as lower per-ride costs, increased availability, and priority access to electric bikes, which align with casual users' preferences for longer, leisurely trips.
## 2. Introduce a Flexible Membership Tier with Perks for Longer Trips
Casual users tend to take longer trips on weekends, likely for leisure. Creating a membership tier that specifically includes perks for longer rides (e.g., a certain number of hours of ride time per month, or free ride time on weekends) could appeal to these users. Additionally, offering an introductory trial membership or a "Weekend Warrior" plan, which includes benefits like a set number of weekend or summer rides, can help casual users experience the benefits of being a member without a full commitment upfront.
## 3. Promote Exclusive Electric Bike Perks for Members
Given the high usage of electric bikes among casual users, promoting member-only perks such as discounted rates or priority access to electric bikes can be a strong incentive. Casual riders who prefer electric bikes may find the added convenience and reduced cost of electric bike usage compelling. Ride-sharing services could emphasize these exclusive benefits through targeted marketing campaigns, particularly at the start of the summer season when casual users are more engaged with the service.



