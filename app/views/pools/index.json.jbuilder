json.array!(@pools) do |pool|
  json.extract! pool, :id, :ip, :user_name, :password, :user_id
  json.url pool_url(pool, format: :json)
end
