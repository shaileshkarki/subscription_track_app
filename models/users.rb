

def find_one_user_by_id(id)
    params = [id]
    sql = "SELECT * FROM users WHERE id = $1;"
    return run_sql(sql,params)[0]        
end

def create_user(user_name, email, password)
    password_digest = BCrypt::Password.create(password)
    params = [user_name, email,  password_digest]
    sql = "INSERT INTO users (user_name, email, password_digest) VALUES ($1,$2,$3);"
    run_sql(sql, params)
end

def find_one_user_by_email(email)
    params = [email]
    sql = "SELECT * FROM users WHERE email = $1;"
    records = run_sql(sql, params)   
    if records.count == 0
        return nil
    else
        return records[0]
    end
end