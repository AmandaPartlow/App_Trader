--See what data looks like

/*SELECT *
FROM app_store_apps
LIMIT 30;*/

--Important columns: name, price, (review_count?), rating

/*SELECT app_store_apps.name AS app_name, play_store_apps.name AS store_name, 
app_store_apps.price AS app_price, play_store_apps.price AS play_price, 
app_store_apps.rating app_rating, play_store_apps.rating AS play_rating
FROM app_store_apps FULL JOIN play_store_apps
USING(name)
WHERE app_store_apps.name IS NOT NULL
OR play_store_apps.name IS NOT NULL;*/

--Didn't work because a separate column for each store was listed. When listed as a singular
--name (in this case 'name'), everything came up in the same column. used distinct to rule out
--duplicates. how do you join on multiple columns? In this case, I am able to join the titles
--from both stores together, but what does it look like when I'm trying to join name, price, and
--rating from both stores all into three columns?

/*SELECT DISTINCT(name)
FROM app_store_apps FULL JOIN play_store_apps
USING (name);*/

--Changing to INNER JOIN because they prefer apps that are on both stores
--Joining names, but averaging price and rating to show 

/*SELECT DISTINCT(name), 
	/*AVG(CAST(app_store_apps.price AS int) + CAST(play_store_apps.price AS int)) AS avg_price, */
	AVG(app_store_apps.rating + play_store_apps.rating ) AS avg_rating
FROM app_store_apps INNER JOIN play_store_apps
USING (name)
GROUP BY name;*/

--only returning 328 titles. seems low. also, can't get prices to average (I think it's not 
--allowing for casting to int because of the dollar sign?)

/*SELECT DISTINCT(name),*/ 
	/*AVG(CAST(app_store_apps.price AS int) + CAST(play_store_apps.price AS int)) AS avg_price,
	AVG(app_store_apps.rating + play_store_apps.rating ) AS avg_rating*/
/*FROM app_store_apps INNER JOIN play_store_apps
USING (name)*/
/*GROUP BY name;*/

/*SELECT name
FROM app_store_apps FULL JOIN play_store_apps
USING (name)
ORDER BY name;*/

--INNER JOIN gives 328, FULL JOIN gives 16526. When I go back and forth, things are being left
--out of INNER JOIN. Maybe slightly different names from one to the other?

/*SELECT app_store_apps.name AS app, play_store_apps.name AS play
FROM app_store_apps FULL JOIN play_store_apps
USING (name);*/

/*SELECT app_store_apps.name
FROM app_store_apps
WHERE name ILIKE '%Wikipedia%';*/

--Final conclusion in regards to full vs inner join issues: this is not a complete set of data.
--Move forward using FULL JOIN and we'll pretend like it's giving the complete list of
--overlapping names

SELECT DISTINCT(name),
	ROUND(ROUND(((app_store_apps.rating + play_store_apps.rating)/2)*2, 0)/2, 1) AS avg_rating,
	(216000*(ROUND(((app_store_apps.rating + play_store_apps.rating)/2)*2, 0)/2) +98000)::money AS net_profit,
	play_store_apps.content_rating AS play_content_rating,
	app_store_apps.content_rating AS app_content_rating,
	CONCAT(primary_genre, ', ' , genres) AS genres
FROM app_store_apps INNER JOIN play_store_apps
USING (name)
WHERE play_store_apps.price = '0'
AND app_store_apps.price = '0'
AND ROUND(ROUND(((app_store_apps.rating + play_store_apps.rating)/2)*2, 0)/2, 1) >=4.5
ORDER BY net_profit DESC;
--GROUP BY (app_store_apps.name,avg_rating, app_store_apps.primary_genre, net_profit, play_content_rating, app_content_rating, genres, total_review_count)
--ORDER BY total_review_count DESC;

-- Sub for median 

/*SELECT percentile_disc(0.5) WITHIN GROUP (ORDER BY((play_store_apps.review_count) +( app_store_apps.review_count :: integer)))
FROM app_store_apps
INNER JOIN play_store_apps
USING (name)
WHERE play_store_apps.price ='0'
AND app_store_apps.price = '0'*/

													
