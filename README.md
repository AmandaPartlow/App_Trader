### Nashville Software School Group Project - Using SQL to Analyze App Data  

*Original assignment: You have been hired by a new company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. App Trader will serve as a broker buying rights to apps from developers then deploying and marketing them. App developers retain **all** money from users purchasing the app, and they retain _half_ of the money made from in-app advertising and in-app purchases. App Trader will be solely responsible for marketing apps they purchase rights to. Unfortunately, the data for Apple App Store apps and Android Play Store Apps is located in separate tables with no referential integrity.*  

This was a group project, worked on by [John Borthick](https://github.com/JohnBorthick), [Ness Artoul](https://github.com/nessartoul), and me. Joining multiple tables together, isolating the relevant columns, and creating calculations that produced revenue data, we used pgAdmin to analyze large amounts of data from the App Store and the Play Store and made recommendations to App Trader for which apps would be the most profitable to buy the rights to.  

This chart shows how much the highest rated apps would make over their projected 10-year longevity.  
![Net Profit Over Time](/assets/net_profit.png)  

This is a screenshot of the script I worked on.  
![Final Script](/assets/script.png)  

I used an inner join to use only information for apps that appeared in both stores. In the select, I first averaged the ratings from the two stores together to create a new rating we could work from. After creating an equation to determine lifetime sales (based on criteria outlined in the assignment), I created a new column called "net_profit". Since the content rating was in a different format in each of the stores, I couldn't combine them effectively, so I added both in as separate columns. I used a concatinate to make one column for all genres the app fit into. Finally, since the free apps were the ones that made the most sense for the buyer to purchase, I set prices equal to zero and since the highest rated apps were the best ones for the buyer to purchase, I set ratings to be at least 4.5 stars.
