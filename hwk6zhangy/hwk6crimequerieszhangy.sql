use
crime_db2022zhangy;

-- 4.
select date (incident_date), count(*) as num_crimes
from t_incident
group by date (incident_date)
order by date (incident_date);

-- 5.
with street_total as
         (select street, count(*) as num_of_incidents
          from t_incident
          group by street)
select *
from street_total
where num_of_incidents = (select max(num_of_incidents) from street_total);

-- 6.
select count(*)
from t_incident
         join t_district on district = code
         join t_neighborhood on t_district.code = t_neighborhood.code and neighborhood = 'North End';

-- 7.
select count(*)
from t_incident
         join t_district on district = code and name = 'Hyde Park';

-- 8.
select offense_code, date (incident_date) as c_date, t_district.name as district
from t_incident
    join t_offense_code
on offense_code = t_offense_code.code and description like 'RAPE%'
    join t_district on district = t_district.code
order by c_date, district;

-- 9.
select code, description, count(incident_number) as num_occurrences
from t_offense_code
         left join t_incident on code = offense_code
group by code
order by num_occurrences desc;

-- 10.
select code, name, count(incident_number) as num_crimes
from t_district
         left join t_incident on code = district
group by code
order by num_crimes desc;

-- 11.
select code, count(distinct district) as num_districts
from t_offense_code
         left join t_incident on code = offense_code
group by code;

-- 12.
select incident_number, name, description, date (incident_date)
from t_incident left join t_district
on district = t_district.code
    left join t_offense_code on offense_code = t_offense_code.code
where date (incident_date) between '2022-12-25' and '2022-12-28'
order by date (incident_date);

-- 13.
with district_crimes as
    (select district, offense_code, count(*) as num_crimes
    from t_incident
    group by district, offense_code),
    district_top as
    (select district, max(num_crimes) as top_crime
    from district_crimes
    group by district)
select t_district.name, t_offense_code.description, district_top.top_crime
from t_district
         left join district_top on t_district.code = district_top.district
         left join district_crimes on district_top.district = district_crimes.district
    and district_top.top_crime = district_crimes.num_crimes
         left join t_offense_code on district_crimes.offense_code = t_offense_code.code;

-- 14.
select t_offense_code.code,
       description,
       group_concat(name)     as districts,
       count(incident_number) as num_crimes
from t_offense_code
         left join t_incident on t_offense_code.code = offense_code
         left join t_district on district = t_district.code
group by t_offense_code.code
order by num_crimes desc;

-- 15.
with avg_crimes as
         (select round(count(*) / count(distinct date (incident_date)), 0) as avg_crime
          from t_incident)
select distinct date (incident_date), avg_crime
from t_incident, avg_crimes
order by date (incident_date);

-- 16.
with day_num as
         (select i_day_of_week,
                 count(*)   num_crimes,
                 CASE
                     WHEN i_day_of_week = 'Monday' THEN 1
                     WHEN i_day_of_week = 'Tuesday' THEN 2
                     WHEN i_day_of_week = 'Wednesday' THEN 3
                     WHEN i_day_of_week = 'Thursday' THEN 4
                     WHEN i_day_of_week = 'Friday' THEN 5
                     WHEN i_day_of_week = 'Saturday' THEN 6
                     ELSE 7
                     END as r
          from t_incident
          group by i_day_of_week
          order by r)
select i_day_of_week, num_crimes
from day_num;

-- 17.
-- NOTE that we could adjust the argument of round() by ourselves
select round(count(*) / count(distinct date (incident_date)), 0)
from t_incident;

-- 18.
select code, description
from t_offense_code
where code not in (select distinct offense_code from t_incident);

select code, description
from t_offense_code
         left join t_incident on code = t_incident.offense_code
where offense_code is null;
