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
["John", "Nick","Steve","Adam","Billy"].each_with_index do |name, index1|
    ["Netflix", "Spotify","Catch of the Day","Foxtel"].each_with_index do |n, index2|
        title = n
        price = 10.5 
        recurring = [1,2,3,4,5,6,7].shuffle.first
        start_date = Date.parse(['2018-12-14','2019-4-14','2020-1-10','2019-10-4'].shuffle.first)
        cancel_date = Date.parse(['2021-12-14','2020-4-14','2021-1-10','2023-10-1'].shuffle.first)
        while(cancel_date<start_date) do
            cancel_date = Date.parse(['2021-12-14','2020-4-14','2021-1-10','2023-10-1'].shuffle.first)
        end
        site_url = 'https://www.netflix.com/au/login'
        user_id = (index1+1)
        create_subscription(title, price, recurring, start_date, cancel_date, site_url, user_id)
    end
end
