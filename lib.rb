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
    elsif num = 7
        result = "Month"
    elsif num = 8
        result = "Day"
    end
end

def deletion_reminder(id)
    today_date = Date.today
    result = find_subscriptions_by_id_and_cancel_date(id, today_date)
    result
end

def calculate_expenses_for_this_month(id)
    # today_date = Date.today
    # expense = 0
    # month_beginning = Date.new(Date.today.year, Date.today.month).to_s
    # month_ending = month_beginning.end_of_month

    # # the code below finds the difference between two dates it takes date in integer yyyy,mm,dd format
    # result_days = (Date.new(Date.today.to_s.split('-').join(','))-Date.new(2020,04,1)).to_i
    
end