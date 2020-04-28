# api and library reference
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'models/subscriptions'
require_relative 'models/users'

# helper methhods

# route to view all subscriptions page
#1 is user id for time being
get '/' do 
  subscriptions = all_subscriptions() 
  # raise subscriptions
  erb(:index, locals: {subscriptions: subscriptions})
end
# route to create new subscription information
get '/subscriptions/new' do
  erb(:new)
end
# show information about individual subscription
get '/subscriptions/:id' do
  subscription = find_one_subscription_by_id(params["id"])
  # user = find_one_user_by_id(dish["user_id"])
  # erb(:show, locals: {dish: dish, user: user})
  erb(:show, locals: {subscription: subscription})
end

get '/subscriptions/:id/edit' do
  subscription = find_one_subscription_by_id(params["id"])     
  erb(:edit, locals:{subscription: subscription})
end

patch '/subscriptions' do
  update_subscription(params[:title], params[:price], params[:recurring], params[:start_date], params[:cancel_date], params[:site_url], params[:user_id],params[:id])
  redirect "/subscriptions/#{params[:id]}"
end

delete '/subscriptions' do 
  delete_subscription(params[:id])   
  redirect "/"
end

post '/subscriptions' do   
  create_subscription(params[:title], params[:price], params[:recurring], params[:start_date], params[:cancel_date], params[:site_url], params[:user_id])
  redirect "/"
end

get '/dishes/new' do
  erb(:new)
end
