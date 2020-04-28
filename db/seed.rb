require 'pg'
# require 'sinatra'

require_relative '../models/subscriptions'
require_relative '../models/users'

# https://www.netflix.com/au/login


# ["John", "Nick","Steve","Adam","Billy"].each do |name|
#     email = ''
#     email = "#{name}@gmail.com"
#     password = "#{name}@"
#     create_user(name, email, password)
# end

# create_subscription (title, price, recurring, start_date, cancel_date, site_url, user_id)
(1..15).each do |n|
    title = "Netflix#{n}"
    price = 10 + n
    recurring = [1,2,3,4,5,6,7].shuffle.first
    start_date = ['20/12/2019','10/5/2018','10/4/2020','10/6/2018'].shuffle.first
    cancel_date = ['20/12/201','10/5/2019','10/4/2022','10/6/2012'].shuffle.first
    site_url = 'https://www.netflix.com/au/login'
    user_id = [1,2,3,4,5].shuffle.first
    create_subscription(title, price, recurring, start_date, cancel_date, site_url, user_id)
end
