create table hotel_copy
like hotel_reservation_dataset;


insert into hotel_copy
select *
from hotel_reservation_dataset;

-- 1. Total Number Of Reservations
select count(Booking_ID) as total_number_of_reservations
from hotel_copy;

-- 2 Most Popular MealPlan
select type_of_meal_plan, count(type_of_meal_plan) as popular_meal_plan
from hotel_copy
group by type_of_meal_plan
limit 1;

-- 3. Average Price for Reservation with Children
select no_of_children, count(Booking_ID) as num_reservations, avg(avg_price_per_room)
from hotel_copy
where no_of_children > 0 
group by no_of_children;

-- 4 Reservations Made for the year 2018
-- The Column 9arrival_date) was stored as a text. To run a query that finds the year 2018, arrival_date has to be changed to a `date` column
update hotel_copy
set arrival_date = STR_TO_DATE(arrival_date, '%d/%m/%Y');

alter table hotel_copy
modify column arrival_date date;

select arrival_date
from hotel_copy;

select year(arrival_date), Booking_ID
from hotel_copy
where year(arrival_date) = 2018 
;

select year(arrival_date), count(Booking_ID) as reservation_numbers
from hotel_copy
where year(arrival_date) = 2018
group by year(arrival_date) 
;

-- 5 Most Commonly Booked Room Type

select room_type_reserved, COUNT(Booking_ID) as num_bookings
from hotel_copy
group by room_type_reserved
order by num_bookings desc
limit 1;

-- 6 Reservation on weekends
select count(Booking_ID) as weekend_reservations
from hotel_copy
where no_of_weekend_nights > 0
;

-- 7. Highest and Lowest Lead Time for reservation
select max(lead_time) as max_lead_time, min(lead_time) as min_lead_time
from hotel_copy;

-- 8. Most Common Market Segment For Reservations
select market_segment_type, count(market_segment_type) as market_segment
from hotel_copy
group by market_segment_type
order by market_segment desc
limit 1;

-- 9. Reservations with Confirmed Booking Status
select count(Booking_ID) as confirmed_booking_status
from hotel_copy
where booking_status = 'Not_Canceled'
;

-- 10. Total NUmbers of Adults and Children across all reservations
select sum(no_of_adults) as total_adults, sum(no_of_children) as total_children
from hotel_copy;


-- 11 Average number of weekend nights for reservations involving children
select avg(no_of_weekend_nights) as avg_children_weekend_nights
from hotel_copy
where no_of_children > 0
;

-- 12 How many reservations were made in each month of the year?
select month(arrival_date) as `month`, year(arrival_date) as `year`, count(Booking_ID) as monthly_reservations
from hotel_copy
group by month(arrival_date), year(arrival_date)
; 

-- 13 What is the average number of nights (both weekend and weekday) spent by guests for each room_tpe
select room_type_reserved, avg(no_of_week_nights + no_of_weekend_nights)  as avg_week_nights
from hotel_copy
group by room_type_reserved;

-- 14 Common room_type for reservations involving children, average price
select room_type_reserved, count(Booking_ID) as children_reserve, avg(avg_price_per_room) as avg_price
from hotel_copy
where no_of_children > 0
group by room_type_reserved 
order by children_reserve
limit 1;



-- Find the market segment type that generates the highest average price per room. 
select market_segment_type, avg(avg_price_per_room) as avg_price
from hotel_copy
group by market_segment_type
order by avg_price desc
limit 1 ;

select *
from hotel_copy;