use cs2;

select 
year_num,
week_num,
num_active_users,
SUM(num_active_users)OVER(ORDER BY year_num, week_num ROWS BETWEEN 
UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_active_users
from 
(
select 
extract(year from activated_at) as year_num,
extract(week from activated_at) as week_num,
count(distinct user_id) as num_active_users
from 
users  
WHERE
state = 'active'
group by year_num,week_num
order by year_num,week_num
) a;

SELECT
distinct user_id,
COUNT(user_id),
SUM(CASE WHEN retention_week = 1 Then 1 Else 0 END) as per_week_retention
FROM 
(
SELECT
a.user_id,
a.signup_week,
b.engagement_week,
b.engagement_week - a.signup_week as retention_week
FROM 
(
(SELECT distinct user_id, extract(week from occurred_at) as signup_week from events_data
WHERE event_type = 'signup_flow'
and event_name = 'complete_signup'
and extract(week from occurred_at) = 18
)a 
LEFT JOIN
(SELECT distinct user_id, extract(week from occurred_at) as engagement_week FROM events_data
where event_type = 'engagement'
)b 
on a.user_id = b.user_id
)
)d 
group by user_id
order by user_id;

SELECT 
extract(year from occurred_at) as year_num,
extract(week from occurred_at) as week_num,
device,
COUNT(distinct user_id) as no_of_users
FROM 
events_data
where event_type = 'engagement'
GROUP by 1,2,3
order by 1,2,3;

SELECT 
engagements, 
total_users, 
engagements/total_users*100 AS engagement_rate
from (	SELECT 
			count(distinct(user_id)) AS total_users,
COUNT(DISTINCT 
CASE 
WHEN action = 'email_open' THEN user_id 
WHEN action = 'email_clickthrough' THEN user_id END)  AS engagements
		FROM email_events) as counts;





