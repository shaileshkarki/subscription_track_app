def run_sql(sql,params)
    conn = PG.connect(dbname: 'subcscription_app')
    #executing sql statement
    records = conn.exec_params(sql,params)
    # connection close
    conn.close()
    return records
end

def all_subscriptions()
    sql = "SELECT * FROM subscriptions"
    params = []
    subscriptions = run_sql(sql,params)
    subscriptions
end

def find_one_subscription_by_id(id)
    sql = "SELECT * FROM subscriptions WHERE id = $1;"
    params = [id]
    subscription = run_sql(sql, params)[0]
    return subscription
end
# <<-SQL is herodocs sql goes in here SQL
def create_subscription (title, price, recurring, start_date, cancel_date, site_url, user_id)  
    params = [title, price, recurring, start_date, cancel_date, site_url, user_id]
    sql = <<-SQL
        INSERT INTO subscriptions (title, price, recurring, start_date, cancel_date, site_url, user_id)
        VALUES ($1, $2, $3, $4, $5, $6, $7);
        SQL
    run_sql(sql, params)
end

def update_subscription(title, price, recurring, start_date, cancel_date, site_url, user_id,id)
    params = [title, price, recurring, start_date, cancel_date, site_url, user_id,id]
    sql = <<-SQL
        UPDATE subscriptions 
        SET title = $1, price = $2, recurring = $3, start_date = $4, cancel_date = $5, site_url = $6, user_id = $7
        WHERE id = $8;
        SQL
    run_sql(sql, params)
end

def delete_subscription(id)
    params = [id]
    sql = "DELETE FROM subscriptions WHERE id = $1;"
    run_sql(sql, params)
end