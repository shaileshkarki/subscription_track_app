# api and library reference
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'pg'
require 'date'
require 'bcrypt'
require_relative 'models/subscriptions'
require_relative 'models/users'
require_relative 'lib'

enable :sessions


# route to view all subscriptions page
#1 is user id for time being
get '/' do 
  if session[:user_id]
    
    subscriptions = all_subscriptions(session[:user_id]) 
    # raise subscriptions['start_date']
    fee = total_fee_for_current_month(session[:user_id])
    # fee = calculate_expenses_for_given_month(session[:user_id],Date.today) 
    deletions = deletion_reminder(session[:user_id])
    erb(:index, locals: {
      subscriptions: subscriptions,
      fee: fee,
      deletions: deletions
      })
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
  erb(:show, locals: {subscription: subscription})
end

get '/subscriptions/:id/edit' do
  subscription = find_one_subscription_by_id(params["id"])   
  erb(:edit, locals:{subscription: subscription})
end

patch '/subscriptions' do
  if session[:user_id]
    user_id = session[:user_id]
    update_subscription(params[:title], params[:price], (params[:recurring].to_i), params[:start_date], params[:cancel_date], params[:site_url], session[:user_id],params[:id])
    redirect "/"
  else
    redirect "/login"
  end
end

delete '/subscriptions' do 
  delete_subscription(params[:id])   
  redirect "/"
end

post '/subscriptions' do   
  if session[:user_id]
    user_id = session[:user_id]
    p params[:recurring]
    p "fdsfadfd"
    #  raise params[:recurring]

    # raise session[:user_id]
    create_subscription(params[:title], params[:price], (params[:recurring].to_i), params[:start_date], params[:cancel_date], params[:site_url], user_id)
    # raise session[:user_id]
    redirect "/"
  else 
    message = ''
    message = "You have to login to access your account"
    erb(:login, locals:{message: message})
  end
end

get '/subscriptions/new' do
  if session[:user_id]==nil
    message = ''
    message = "You have to login before you add the information."
    erb(:login, locals:{message: message})
  else
    erb(:new)
  end

end
get '/login' do
  session[:user_id] = nil
  session[:user_name] = nil
  message = ''
  # message = "You already have an account. Try Login!"
  erb(:login, locals:{message: message})
end
post '/login' do
  user = find_one_user_by_email(params[:email]) 
  if user && BCrypt::Password.new(user["password_digest"]) == params[:password]
      session[:user_id] = user['id']
      session[:user_name] = user['user_name']
      # raise here
      redirect "/"
  else
    message = ''
    message = "Email and Password did not match. Try Again!"
    erb(:login, locals: {message: message})
  end
end

get '/signup' do 
  session[:user_id] = nil
  session[:user_name] = nil
  message = ''
  erb(:signup, locals:{message: message})
end
post '/signup' do
  message = ''
  user = find_one_user_by_email(params[:email]) 
  if user
    message = "You already have an account. Try login!"
    erb(:login, locals:{message: message})
  else
    if params[:password] == params[:re_password]
      create_user(params[:user_name], params[:email], params[:password])
      user = find_one_user_by_email(params[:email])
      session[:user_id] = user['id']
      session[:user_name] = user['user_name']
      redirect "/"
    else
      message = ''
      message = "Password and re-password did not match. Try again!"
      erb(:signup, locals:{message: message})
    end
  end
end

delete '/logout' do
  session[:user_id] = nil
  session[:user_name] = nil
  redirect(:login)
end

# get '/:anything' do
#   erb(:under_construction)
# end
