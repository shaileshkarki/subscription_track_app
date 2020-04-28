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
        result = "Half Year"
    elsif num == 5
        result = "Fort Night"
    elsif num == 6
        result = "Week"
    elsif num = 7
        result = "Month"
    else
        result = "Day"
    end
end