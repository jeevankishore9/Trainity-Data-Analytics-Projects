###  Marketing
#### Rewarding Most Loyal Users  

use ig_clone;
select * from users
order by date (created_at)
limit 5;

### Remind Inactive Users to Start Posting
select * from users
left join photos
on users.id = photos.user_id
where user_id is null;

### Declaring Contest Winner
select  users.username, users.id, count(likes.photo_id) as total_likes
from users 
left join photos 
on  users.id = photos.user_id 
left join likes 
on photos.id = likes.photo_id 
group by users.username, likes.photo_id, users.id
order by count(likes.photo_id) desc
limit 1;

### Top 5 Hashtag Researching
select tag_name as "TOP 5 Tags", count(tags.id) as "No. of Times Used"
from photos 
left join photo_tags 
on photos.id = photo_tags.photo_id
left join tags 
on photo_tags.tag_id = tags.id
Group by tags.id
order by count(id) desc
limit 5;

### Best Day for Launch of AD Campaign
select dayname(created_at) as Days_of_the_week, count(*) as Total
from users
group by Days_of_the_week
order by Total desc;

###Investor Metrics
###User Engagement

#total no of users of instagram
select count(id) as total_no_of_users from users;

#total no of photos on instagram
select count(id) as total_no_of_photos from photos;

#average post per user
with cte as
( select users.id, count(photos.id) as post_per_user
from users 
left join photos 
on users.id = photos.user_id
group by users.id
order by post_per_user desc )
select avg(post_per_user) as "Average Post per User"
from cte;

###Bots & Fake Accounts
with cte as 
(select likes.user_id, count(likes.user_id) as no_of_likes
from photos 
left join likes 
on photos.id = likes.photo_id
left join users 
on photos.user_id = users.id
group by likes.user_id)
select user_id, users.username,no_of_likes
from cte
left join users 
on cte.user_id = users.id
where no_of_likes = 257;














