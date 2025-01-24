USE zomato_restaurants;

-- best dining rating
SELECT restaurant_name, Dining_Rating AS highest_dining_rating
FROM Restaurants r
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id
WHERE Dining_rating = (SELECT MAX(dining_rating) FROM rating);

-- best delivery
SELECT restaurant_name, Delivery_Rating AS highest_delivery_rating
FROM Restaurants r
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id
WHERE Delivery_rating = (SELECT MAX(delivery_rating) FROM rating);

-- Affordable restaurants
 SELECT restaurant_name, price_for_two, Dining_Rating 
 FROM Restaurants r 
 JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
 WHERE price_for_two < 600 ORDER BY Dining_Rating DESC LIMIT 10;
 
 -- popular cuisine
SELECT cuisine, COUNT(*) AS num_restaurants, ROUND(AVG(Dining_Rating),2) AS avg_rating
FROM Restaurants r
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id
GROUP BY cuisine
ORDER BY num_restaurants DESC;

-- Areas with most high rated restaurants
SELECT l.location, COUNT(*) AS high_rated_restaurants 
FROM Location l 
JOIN Restaurants r ON l.location_id = r.location_id 
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
WHERE Dining_Rating > 4.5 GROUP BY l.location ORDER BY high_rated_restaurants DESC;

-- Outdoor Seating and Buffet
SELECT restaurant_name, Dining_Rating 
FROM Restaurants r 
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
WHERE features LIKE '%outdoor seating%' 
AND features LIKE '%buffet%'  ORDER BY Dining_Rating DESC LIMIT 5;

-- Restaurants with similar cuisines and price range
SELECT restaurant_name, cuisine, price_for_two, Dining_Rating 
FROM Restaurants r 
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
WHERE price_for_two BETWEEN 500 AND 1000 
AND cuisine LIKE '%South Indian%' ORDER BY Dining_Rating DESC;

-- Features that high rated restaurants have
SELECT features, COUNT(*) AS feature_count, ROUND(AVG(Dining_Rating),2) AS avg_rating 
FROM Restaurants r 
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
WHERE Dining_Rating > 4.5 GROUP BY features ORDER BY feature_count DESC;

-- Delivery rating > Dining rating
SELECT DISTINCT r.restaurant_name, l.location, rt.Dining_Rating, rt.Delivery_Rating,ROUND((rt.Delivery_Rating - rt.Dining_Rating),2) AS rating_difference 
FROM Restaurants r 
JOIN Rating rt ON r.Restaurant_id = rt.restaurant_id 
JOIN Location l ON r.location_id = l.location_id 
WHERE (rt.Delivery_Rating - rt.Dining_Rating) > 1.5 ORDER BY rating_difference DESC;

-- Most cuisine variety
SELECT l.location, COUNT(DISTINCT cuisine) AS cuisine_variety 
FROM Location l 
JOIN Restaurants r ON l.location_id = r.location_id 
GROUP BY l.location ORDER BY cuisine_variety DESC;



