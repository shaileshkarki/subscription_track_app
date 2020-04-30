def logged_in?
    if session[:user_id]
        return true
    else
        return false
    end
end

# potential crash if you try to use it when you are not logged in
def current_user
    find_one_user_by_id(session[:user_id])
end


def check_recurring(num)
    num = num.to_i
    result = ''
    if num == 1
        result = "Year"
    elsif num == 2
        result = "Half Year"
    elsif num == 3
        result = "Quarter"
    elsif num == 4
        result = "Bi-month"
    elsif num == 5
        result = "Fort Night"
    elsif num == 6
        result = "Week"
    elsif num == 7
        result = "Month"
    elsif num == 8
        result = "Day"
    end
end

def deletion_reminder(id)
    today_date = Date.today
    result = find_subscriptions_by_id_and_cancel_date(id, today_date)
    result
end


def number_of_days_calculator(start_date, end_date)
    start_date = Date.strptime(start_date)
    end_date = Date.strptime(end_date)
    number_of_days = (end_date - start_date).to_i
    return number_of_days
end

def find_last_day_of_month(date)
    if(date.class != Date)
        date = Date.parse(date)
    end
    last_day_of_month = Date.civil(date.year,date.month,-1)
    return last_day_of_month.strftime("%Y-%m-%d") 
end
#assuming billing cycle is based on 1 month = 30 days
# def calculate_expenses_for_given_month(id,date)
#     fee = 0.0
#     first_day_of_month = (date).strftime("%Y-%m-01")
#     # Date.strptime(date, "%Y-%m-01")
#     # Date.strptime(date).strftime("%Y-%m-01")
#     last_day_of_month = find_last_day_of_month(date)
    
#     billing_start = 0
#     billing_end = 0
#     days_to_pay = 0
#     weeks_to_pay = 0
#     days_to_pay = 0
#     # days_in_given_month = number_of_days_calculator(first_day_of_month,last_day_of_month)
#     subscriptions = all_subscriptions(id)
#     subscriptions.each do |subscription|
#         if(subscription['recurring']==1)
#             month_gap = ((Date.strptime(subscription['start_date'], '%Y/%m/%d')).month-Date.strptime(first_day_of_month, '%Y/%m/%d').month)
#             if(month_gap == 0)
#                 fee += subscription['price'].to_f
#             end
#         elsif(subscription['recurring']==2)
#             month_gap = ((Date.strptime(subscription['start_date'], '%Y/%m/%d')).month-Date.strptime(first_day_of_month, '%Y/%m/%d').month)
#             if(month_gap == 0 ||month_gap == 6 || month_gap == -6 )
#                 fee += subscription['price'].to_f
#             end
#         elsif(subscription['recurring']==3)
#             month_gap = ((Date.strptime(subscription['start_date'], '%Y/%m/%d')).month-Date.strptime(first_day_of_month, '%Y/%m/%d').month)
#             if(month_gap == 0 ||month_gap == 3 || month_gap == -3 )
#                 fee += subscription['price'].to_f
#             end
#         elsif(subscription['recurring']==4)
#             month_gap = ((Date.strptime(subscription['start_date'], '%Y/%m/%d')).month-Date.strptime(first_day_of_month, '%Y/%m/%d').month)
#             if(month_gap == 0 ||month_gap == 2 || month_gap == -2 )
#                 fee += subscription['price'].to_f
#             end
#         elsif(subscription['recurring']==5)
#             if(Date.strptime(subscription['start_date'], '%Y/%m/%d').between?(first_day_of_month, last_day_of_month) && number_of_days_calculator(Date.strptime(last_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))<15)
#                 fee += subscription['price'].to_f
#             else
#                 fee += (subscription['price'].to_f*2)
#             end
#         elsif(subscription['recurring']==6)
#             billing_end = 0
#             if(Date.strptime(subscription['start_date'], '%Y/%m/%d').between?(Date.strptime(first_day_of_month, '%Y/%m/%d'),Date.strptime(last_day_of_month, '%Y/%m/%d')))
#                 weeks_to_pay = ((number_of_days_calculator(Date.strptime(last_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d')))/7).ceil
#             else
#                 billing_start = number_of_days_calculator(Date.strptime(firstst_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))
#                 billing_end = number_of_days_calculator(Date.strptime(last_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))
#                 weeks_to_pay = ((billing_end - billing_start)/7).ceil
#             end
#             fee += (subscription['price'].to_f*weeks_to_pay)
#         elsif(subscription['recurring']==7)
#             fee += subscription['price'].to_f
#         elsif(subscription['recurring']==8)
#             if(Date.strptime(subscription['start_date'], '%Y/%m/%d').between?(Date.strptime(first_day_of_month, '%Y/%m/%d'), Date.strptime(last_day_of_month, '%Y/%m/%d')))
#                 days_to_pay = number_of_days_calculator(Date.strptime(last_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))
#             else
#                 billing_start = number_of_days_calculator(Date.strptime(first_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))
#                 billing_end = number_of_days_calculator(Date.strptime(last_day_of_month, '%Y/%m/%d'),Date.strptime(subscription['start_date'], '%Y/%m/%d'))
#                 days_to_pay = billing_end - billing_start
#             end
#             fee += (subscription['price'].to_f*days_to_pay)
#         end
#     end
#     return fee
# end
# Date.new(2020,4,01)-Date.new(2018,5,20)
# Date.new(2018,5,20).next_day(683).to_s
# Date.new(2018,5,20).next_day((Date.strptime("2020-05-19")).year-Date.new(2018,5,20).year)*365)
# year_gap = ((Date.strptime("2020-04-19")).year-Date.new(2018,10,20).year)
# month_gap = ((Date.strptime("2020-04-19")).month-Date.new(2018,10,20).month)
# Date.new(2018,10,20).next_month((year_gap*12)+(month_gap+6)).to_s
# Date.new(2018,10,20).next_day(result).between?(Date.today, Date.civil(2020,4,-1))

#Date.strptime(find_last_day_of_month(Date.today), '%Y-%m-%d')
# def string_to_date(string_date)
#     # if(string_date.class != Date)
#         string_date = Date.strptime(string_date, '%Y-%m-%d')
#     # end
#     # string_date
# end
def create_an_array_of_dates(start_date,start_month_date,end_month_date,num)
    start_date = start_date.to_s
    end_month_date = end_month_date.to_s
    start_month_date =start_month_date. to_s
    num = days_interval(num).to_i
    date_array = []
    if(start_date <= end_month_date)
        while Date.parse(start_date) <= Date.parse(end_month_date)  do
            next_time = Date.parse(start_date).next_day(num).to_s
            if(Date.parse(next_time)>=Date.parse(start_month_date)&&Date.parse(next_time)<=Date.parse(end_month_date) )
                date_array.push(next_time)
            end
            start_date  = next_time
        end
    end
    date_array       
end


# create_an_array_of_dates("2019-04-1","2020-04-1","2020-04-30",7)

def days_interval(num)
    # num is recurring
    # num = num.to_i
    if (num == 1 || num == "1")
        # result = "Year"
        days = 365
    elsif (num == 2 || num == "2")
        # result = "Half Year"
        days = 182
    elsif (num == 3 || num == "3")
        # result = "Quarter"
        days = 91
    elsif (num == 4 || num == "4")
        # result = "Bi-month"
        days = 360
    elsif (num == 5 || num == "5")
        # result = "Fort Night"
        days = 14
    elsif (num == 6 || num == "6")
        # result = "Week"
        days = 7
    elsif (num == 7 || num == "7")
        # result = "Month"
        days = 30
    elsif (num == 8 || num == "8")
        days = 1
        # result = "Day"
    end
    days
end
#worked
# def total_fee_for_current_month(id)
#     fee = 0.0 
#     last_day_of_month = find_last_day_of_month((Date.today).to_s) #gives date in string format
#     first_day_of_month = Date.parse(last_day_of_month).strftime("%Y-%m-01") #gives date in string format
#     subscriptions = all_subscriptions(id)
#     subscriptions.each do |subscription|
#         num = subscription['recurring']
#         if(Date.parse(last_day_of_month)>=Date.parse(subscription['start_date']))
#             if (num == 1 || num == "1")
#                 # result = "Year"
#                 price = subscription['price'].to_f
#                 start_date = subscription['start_date']
#                 num = subscription['recurring']
#                 array_of_pay_dates = create_an_array_of_dates(start_date,first_day_of_month,last_day_of_month,num)
#                 fee += (price*array_of_pay_dates.count)
#             elsif (num == 2 || num == "2")
#                 # result = "Half Year"
#                 price = subscription['price'].to_f
#                 start_date = subscription['start_date']
#                 num = subscription['recurring']
#                 array_of_pay_dates = create_an_array_of_dates(start_date,first_day_of_month,last_day_of_month,num)
#                 fee += (price*array_of_pay_dates.count)
#             elsif (num == 3 || num == "3")
#                 price = subscription['price'].to_f
#                 start_date = subscription['start_date']
#                 num = subscription['recurring']
#                 array_of_pay_dates = create_an_array_of_dates(start_date,first_day_of_month,last_day_of_month,num)
#                 fee += (price*array_of_pay_dates.count)
#             elsif (num == 4 || num == "4")
#                 price = subscription['price'].to_f
#                 start_date = subscription['start_date']
#                 num = subscription['recurring']
#                 array_of_pay_dates = create_an_array_of_dates(start_date,first_day_of_month,last_day_of_month,num)
#                 fee += (price*array_of_pay_dates.count)
#             elsif (num == 5 || num == "5")
#                 # result = "Fort Night"
#                 if((Date.parse(first_day_of_month)<Date.parse(subscription['start_date']))&&(Date.parse(last_day_of_month)>=Date.parse(subscription['start_date'])))
#                     days = number_of_days_calculator(subscription['start_date'], last_day_of_month)
#                     fee += ((days/14).to_i*subscription['price'].to_f)
#                 else
#                     fee += (2.to_i*subscription['price'].to_f)
#                 end
#             elsif (num == 6 || num == "6")
#                 # result = "Week"
#                 if((Date.parse(first_day_of_month)<Date.parse(subscription['start_date'])))
#                     days = number_of_days_calculator(subscription['start_date'], last_day_of_month)
#                     fee += ((days/7).to_i*subscription['price'].to_f)
#                 else
#                     days = number_of_days_calculator(first_day_of_month, last_day_of_month)
#                     fee += ((days/7).to_i*subscription['price'].to_f)
#                 end
#             elsif (num == 7 || num == "7")
#                 # result = "Month"
#                 if((Date.parse(last_day_of_month)>=Date.parse(subscription['start_date'])))
#                     fee += subscription['price'].to_f
#                 end
#             elsif (num == 8 || num == "8")
#                 if((Date.parse(first_day_of_month)>=Date.parse(subscription['start_date'])))  
#                     days = number_of_days_calculator(first_day_of_month, last_day_of_month)
#                     fee += ((days).to_i*subscription['price'].to_f)
#                 else
#                     days = number_of_days_calculator(Date.parse(subscription['start_date']), last_day_of_month)
#                     fee += ((days).to_i*subscription['price'].to_f)
#                 end
#             end
#         else
#             fee += 0
#         end
#     end
#     return fee
# end

# total_fee_for_current_month(5)

def total_fee_for_current_month(id)
        fee = 0.0 
        last_day_of_month = find_last_day_of_month((Date.today).to_s) #gives date in string format
        first_day_of_month = Date.parse(last_day_of_month).strftime("%Y-%m-01") #gives date in string format
        subscriptions = all_subscriptions(id)
        subscriptions.each do |subscription|
            num = subscription['recurring'].to_i
            price = subscription['price'].to_f
                start_date = subscription['start_date']
                num = subscription['recurring']
                array_of_pay_dates = create_an_array_of_dates(start_date,first_day_of_month,last_day_of_month,num)
                fee += (price*array_of_pay_dates.count)
                    
        
        end
        return fee
    end