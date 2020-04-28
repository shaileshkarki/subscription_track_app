require 'pg'
def run_sql(sql,params)
    conn = PG.connect(dbname: 'subcscription_app')
    #executing sql statement
    records = conn.exec_params(sql,params)
    # connection close
    conn.close()
    return records
end

def all_subscriptions(user_id)
    sql = "SELECT * FROM subscriptions WHERE user_id = $1"
    params = [user_id]
    subscriptions = run_sql(sql,params)
    subscriptions
end

def find_one_subscription_by_id(id)
    sql = "SELECT * FROM subscriptions WHERE id = $1;"
    params = [id]
    subscription = run_sql(sql, params)[0]
    return subscription
end