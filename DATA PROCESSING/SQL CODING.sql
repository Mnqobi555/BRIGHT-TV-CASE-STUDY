
SELECT 
    A.UserID0,
    B.Name,
    B.Surname,
    B.Age,
    CASE 
        WHEN B.Age BETWEEN 0 AND 12 THEN 'Infant (0-12)'
        WHEN B.Age BETWEEN 13 AND 17 THEN 'Teen (13-17)'
        WHEN B.Age BETWEEN 18 AND 24 THEN 'Young Adult (18-24)'
        WHEN B.Age BETWEEN 25 AND 34 THEN 'Adult (25-34)'
        WHEN B.Age BETWEEN 35 AND 49 THEN 'Mid-Age (35-49)'
        WHEN B.Age >= 50 THEN 'Senior (50+)'
        ELSE 'Unknown'
    END AS age_group,
    B.Province,
    B.Gender,
    B.Race,
    A.Date,
    A.Time,
    from_utc_timestamp(
        to_timestamp(concat(A.Date, ' ', A.Time), 'M/d/yyyy HH:mm'), 
        'Africa/Johannesburg'
    ) AS sa_time,
    A.Channel2,
    A.`Duration 2`
FROM workspace.default.viewership_separate AS A
LEFT JOIN workspace.default.user_profile_separate AS B
    ON A.UserID0 = B.UserID;



--THIS IS JUST TO CHECK IF THE TABLE IS LOADED CORRECTLY AND I AM ABLE TO READ IT PROPERLY

select * from `workspace`.`default`.`viewership_separate` limit 100;
select * from `workspace`.`default`.`user_profile_separate` limit 100;



--------------------------------------------------------------
--1.CHECKING THE DATE RANGE
--------------------------------------------------------------

--DATA WAS COLLECTED FROM 1/1/2016 TO 3/9/2016
SELECT min(date) as min_date, max(date) as max_date
FROM workspace.default.viewership_separate;



--------------------------------------------------------------
--2.CHECKING THE AGE RANGE
--------------------------------------------------------------

--THE MINIMUM AGE IS 0 AND THE MAXIMUM AGE IS 114
SELECT min(Age ) as min_age, max(Age) as max_age
FROM `workspace`.`default`.`user_profile_separate`;



--------------------------------------------------------------
--3.CHECKING THE AMOUNT OF CHANNELS IN THE DATASET
--------------------------------------------------------------

--WE HAVE 21 DIFFERENT CHANNELS 
SELECT DISTINCT Channel2
FROM workspace.default.viewership_separate;



--------------------------------------------------------------
--4.CHECKING WHICH GENDER WATCHES TV THE MOST
--------------------------------------------------------------

--WE HAVE 3918 MALES AND 537 FEMALES
SELECT Gender, count(*) as total
FROM `workspace`.`default`.`user_profile_separate`
WHERE Gender IS NOT NULL
GROUP BY Gender
ORDER BY total DESC;



--------------------------------------------------------------
--5.CHECKING THE MIN AND MAX DURATION
--------------------------------------------------------------

--MIN DURATION 00 MINS AND MAX DURATION IS 11 HOURS 29 MINS AND 28 SECONDS
SELECT min(`Duration 2`) as min_duration, max(`Duration 2`) as max_duration
FROM workspace.default.viewership_separate;



-------------------------------------------------------------------------
--6.TOTAL NUMBER OF PROVINCES IN THE DATASET AND CONSUMPTION BY PROVINCE
-------------------------------------------------------------------------

--WE HAVE 10 PROVINCES
SELECT Province, count(*) as total
FROM `workspace`.`default`.`user_profile_separate`
WHERE Province IS NOT NULL
GROUP BY Province
ORDER BY total DESC;



--------------------------------------------------------------
--7.UTC TO SA TIME CONVERSION
--------------------------------------------------------------

SELECT 
    *,
    from_utc_timestamp(to_timestamp(concat(Date, ' ', Time), 'M/d/yyyy HH:mm'), 'Africa/Johannesburg') AS sa_time
FROM 
    workspace.default.viewership_separate;



--------------------------------------------------------------
--8.TOTAL USERS AND SESSION
--------------------------------------------------------------

SELECT 
    COUNT(DISTINCT UserID0) AS total_users,
    COUNT(*) AS total_sessions
FROM workspace.default.viewership_separate;



SELECT 
    date_format(to_date(Date, 'M/d/yyyy'), 'yyyy-MM') AS year_month,
    COUNT(DISTINCT UserID0) AS active_users,
    COUNT(*) AS total_sessions
FROM workspace.default.viewership_separate
WHERE Date IS NOT NULL
GROUP BY date_format(to_date(Date, 'M/d/yyyy'), 'yyyy-MM')
ORDER BY year_month;



SELECT 
    HOUR(from_utc_timestamp(to_timestamp(concat(Date, ' ', Time), 'M/d/yyyy HH:mm'), 'Africa/Johannesburg')) AS hour_of_day,
    COUNT(*) AS total_sessions
FROM workspace.default.viewership_separate
GROUP BY HOUR(from_utc_timestamp(to_timestamp(concat(Date, ' ', Time), 'M/d/yyyy HH:mm'), 'Africa/Johannesburg'))
ORDER BY total_sessions DESC;



--------------------------------------------------------------
--9. FACTORS INFLUENCING CONSUMPTION 
--------------------------------------------------------------

SELECT 
    Channel2,
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT UserID0) AS unique_viewers,
    AVG(`Duration 2`) AS avg_duration
FROM workspace.default.viewership_separate
GROUP BY Channel2
ORDER BY total_sessions DESC;



SELECT 
        *,
        CASE 
            WHEN Age BETWEEN 0 AND 12 THEN 'Infant (0-12)'
            WHEN Age BETWEEN 13 AND 17 THEN 'Teen (13-17)'
            WHEN Age BETWEEN 18 AND 24 THEN 'Young Adult (18-24)'
            WHEN Age BETWEEN 25 AND 34 THEN 'Adult (25-34)'
            WHEN Age BETWEEN 35 AND 49 THEN 'Mid-Age (35-49)'
            WHEN Age >= 50 THEN 'Senior (50+)'
            ELSE 'Unknown'
        END AS age_group
        FROM `workspace`.`default`.`user_profile_separate`
        WHERE Age IS NOT NULL
        ORDER BY age_group;

--------------------------------------------------------
--10.LOW CONSUMPTION DAYS AND CONTENT RECOMMENDATIONS
--------------------------------------------------------

SELECT 
    date_format(to_date(Date, 'M/d/yyyy'), 'EEEE') AS day_name,
    dayofweek(to_date(Date, 'M/d/yyyy')) AS day_of_week,
    COUNT(*) AS total_sessions
FROM workspace.default.viewership_separate
GROUP BY day_name, day_of_week
ORDER BY total_sessions ASC;

--------------------------------------------------------
--11.TOP CHANNELS BY PROVINCE AND GENDER
--------------------------------------------------------
SELECT 
    p.Province,
    t.Channel2,
    COUNT(*) AS total_sessions
FROM `workspace`.`default`.`viewership_separate` t
LEFT JOIN `workspace`.`default`.`user_profile_separate` p
    ON t.UserID0 = p.UserID
WHERE p.Province IS NOT NULL
GROUP BY p.Province, t.Channel2
ORDER BY p.Province, total_sessions DESC;

SELECT 
    p.Gender,
    t.Channel2,
    COUNT(*) AS total_sessions
FROM `workspace`.`default`.`viewership_separate` t
LEFT JOIN `workspace`.`default`.`user_profile_separate` p
    ON t.UserID0 = p.UserID
    WHERE p.Gender IS NOT NULL
GROUP BY p.Gender, t.Channel2
ORDER BY p.Gender, total_sessions DESC;


