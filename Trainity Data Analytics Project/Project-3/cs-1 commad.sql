use cs1;

###Number of jobs reviewed
select ds, count(job_id) as 'Jobs Reviewed per day', sum(time_spent)/3600 as 'Hours spent per Day'
from job_data  
where ds >='2020-11-01'  and ds <='2020-11-30'  
group by ds ;

###Throughput
SELECT ds,
sum(jobs) over (order by ds rows between 6 preceding and current row) / 
sum(total_time) as throughput_7day_rolling_avg
from
(SELECT ds, COUNT(job_id) as jobs, SUM(time_spent) as total_time
FROM job_data where ds >= '2020-11-01' and ds <='2020-11-30'
GROUP BY ds
) d
group by ds;

###Percentage share of each language
select language, (count(*)/(select count(*) from job_data))*100 as percentage
from job_data
group by language;

###Duplicate rows
select job_id, count(job_id) as duplicate_rows
from job_data
group by job_id
having count(*) > 1;




