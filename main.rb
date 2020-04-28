# api and library reference
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'models/subscriptions'
require_relative 'models/users'
require_relative 'lib'
enable :sessions


# route to view all subscriptions page
#1 is user id for time being
get '/' do 
  if session[:user_id]
    subscriptions = all_subscriptions(session[:user_id])  
    # raise subscriptions
    erb(:index, locals: {subscriptions: subscriptions})
  else
    message = ''
    message = "Login to access your account"
    erb(:login, locals: {message: message})
  end
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
  # redirect "/subscriptions/#{params[:id]}"
  redirect "/"
end

delete '/subscriptions' do 
  delete_subscription(params[:id])   
  redirect "/"
end

post '/subscriptions' do   
  if logged_in?
    user_id = session[:user_id]
    create_subscription(params[:title], params[:price], params[:recurring], params[:start_date], params[:cancel_date], params[:site_url], user_id)
    redirect "/"
  else 
    message = ''
    message = "You have to login to access your account"
    erb(:login, locals:{message: message})
  end
end

get '/dishes/new' do
  erb(:new)
end

post '/login' do
  user = find_one_user_by_email(params[:email]) 
  if user && BCrypt::Password.new(user["password_digest"]) == params[:password]
      session[:user_id] = user['id']
      session[:user_name] = user['user_name']
  else
    message = ''
    message = "Email and Password did not match. Try Again!"
    erb(:login, locals: {message: message})
  end
end

get '/signup' do 
  erb(:signup)
end
post '/signup' do
  user = find_one_user_by_email(params[:email]) 
  if user
    message = ''
    message = "You already have an account. Try Login!"
    erb(:login, locals:{message: message})
  else
    session[:user_id] = user['id']
    redirect "/"
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect(:login)
end

