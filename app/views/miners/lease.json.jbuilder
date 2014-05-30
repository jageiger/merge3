json.array!(@miners) do |miner|
  json.extract! miner, :id, :name, :ip, :state, :pool_id
  json.url miner_url(miner, format: :json)
end