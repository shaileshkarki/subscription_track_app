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
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    number_of_days = (end_date - start_date).to_i
    return number_of_days
end

def find_last_day_of_month(date)
    last_day_of_month = Date.civil(date.year,date.month,-1)
    return last_day_of_month.strftime("%Y-%m-01")
end
#assuming billing cycle is based on 1 month = 30 days
def calculate_expenses_for_given_month(id,date)
    fee = 0.0
    first_day_of_month = (date).strftime("%Y-%m-01")
    # Date.strptime(date, "%Y-%m-01")
    # Date.parse(date).strftime("%Y-%m-01")
    last_day_of_month = find_last_day_of_month(date)
    
    billing_start = 0
    billing_end = 0
    days_to_pay = 0
    weeks_to_pay = 0
    days_to_pay = 0
    # days_in_given_month = number_of_days_calculator(first_day_of_month,last_day_of_month)
    subscriptions = all_subscriptions(id)
    subscriptions.each do |subscription|
        if(subscription['recurring']==1)
            month_gap = ((Date.parse(subscription['start_date'])).month-Date.parse(first_day_of_month).month)
            if(month_gap == 0)
                fee += subscription['price']
            end
        elsif(subscription['recurring']==2)
            month_gap = ((Date.parse(subscription['start_date'])).month-Date.parse(first_day_of_month).month)
            if(month_gap == 0 ||month_gap == 6 || month_gap == -6 )
                fee += subscription['price']
            end
        elsif(subscription['recurring']==3)
            month_gap = ((Date.parse(subscription['start_date'])).month-Date.parse(first_day_of_month).month)
            if(month_gap == 0 ||month_gap == 3 || month_gap == -3 )
                fee += subscription['price']
            end
        elsif(subscription['recurring']==4)
            month_gap = ((Date.parse(subscription['start_date'])).month-Date.parse(first_day_of_month).month)
            if(month_gap == 0 ||month_gap == 2 || month_gap == -2 )
                fee += subscription['price']
            end
        elsif(subscription['recurring']==5)
            if(Date.parse(subscription['start_date']).between?(first_day_of_month, last_day_of_month) && number_of_days_calculator(Date.parse(last_day_of_month),Date.parse(subscription['start_date']))<15)
                fee += subscription['price']
            else
                fee += (subscription['price']*2)
            end
        elsif(subscription['recurring']==6)
            billing_end = 0
            if(Date.parse(subscription['start_date']).between?(Date.parse(first_day_of_month),Date.parse(last_day_of_month)))
                weeks_to_pay = ((number_of_days_calculator(Date.parse(last_day_of_month),Date.parse(subscription['start_date'])))/7).ceil
            else
                billing_start = number_of_days_calculator(Date.parse(firstst_day_of_month),Date.parse(subscription['start_date']))
                billing_end = number_of_days_calculator(Date.parse(last_day_of_month),Date.parse(subscription['start_date']))
                weeks_to_pay = ((billing_end - billing_start)/7).ceil
            end
            fee += (subscription['price']*weeks_to_pay)
        elsif(subscription['recurring']==7)
            fee += subscription['price']
        elsif(subscription['recurring']==8)
            if(Date.parse(subscription['start_date']).between?(Date.parse(first_day_of_month), Date.parse(last_day_of_month)))
                days_to_pay = number_of_days_calculator(Date.parse(last_day_of_month),Date.parse(subscription['start_date']))
            else
                billing_start = number_of_days_calculator(Date.parse(first_day_of_month),Date.parse(subscription['start_date']))
                billing_end = number_of_days_calculator(Date.parse(last_day_of_month),Date.parse(subscription['start_date']))
                days_to_pay = billing_end - billing_start
            end
            fee += (subscription['price']*days_to_pay)
        end
    end
    return fee
end
# Date.new(2020,4,01)-Date.new(2018,5,20)
# Date.new(2018,5,20).next_day(683).to_s
# Date.new(2018,5,20).next_day((Date.parse("2020-05-19")).year-Date.new(2018,5,20).year)*365)
# year_gap = ((Date.parse("2020-04-19")).year-Date.new(2018,10,20).year)
# month_gap = ((Date.parse("2020-04-19")).month-Date.new(2018,10,20).month)
# Date.new(2018,10,20).next_month((year_gap*12)+(month_gap+6)).to_s
# Date.new(2018,10,20).next_day(result).between?(Date.today, Date.civil(2020,4,-1))