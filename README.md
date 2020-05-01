# subscription_track_app (Subscription Information Tracker)

Link to the app:
https://warm-sands-35456.herokuapp.com/

Username: Billy@gmail.com

Password: Billy@

This is a web app that helps users to keep the information of services they have suscribed and how much they are spending on those subscriptions for the month. 

## Using the app

Users can only access the index or home page when they are logged in. In the home/index page user can view all the list of subscriptions they have made. If they want to delete information about a subscription they can press delete button. If they want to update the information, they can click on update button(link).
If the user wants to add the information about the new subscription, they can click "Add New Subscription". While adding the information, they can eneter the cancel date, which is the day, they want to cancel the service. And, on the specified cancel date, reminder will be shown suggesting to cancel the subscription and this information will be there until the user delete the subscription information or update the cancel date to future dates. 
 The app will also show the total expense that will be incurred by the user for current month based on the services they have subscribed. Even if a subscription passed the cancel date, it is assumed that the user is using it and taken into account while calculating the expenses for subscription.

 ## Assumptions while calculating monthly expenses on subscription 
1. Yearly subscription fee is incurred on 365 days
2. Half-yearly subscription fee is incurred on 182 days
3. Quarterly subscription fee is incurred on 91 days
4. Bi-monthly subscription fee is incurred on 60 days
5. Monthly subscription fee is incurred on 30 days
6. Fort-nightly subscription fee is incurred on 14 days
7. Weekly subscription fee is incurred on 7 days
8. Daily subscription fee is incurred on 1 day(next).

## Technology used
#### Backend: Ruby 
#### Libraries
1. Sinatra web application library
2. Ruby pg 
3. Ruby Date library
4. Bcrypt
#### Database: PostgreSQL
#### Frontend:
1. HTML
2. CSS
3. Javascript
#### Deployment: Heroku
#### Version Control: Git

## Future Tasks
1. Testing
2. Admin Page
3. Update Account Page
4. Static page like About Us, Contact Us
5. Improve Design (CSS) and Add more Validation (Javascript)
