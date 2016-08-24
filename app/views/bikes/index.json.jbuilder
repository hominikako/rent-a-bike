json.array!(@bikes) do |bike|
  json.extract! bike, :id, :type, :available, :status, :colour, :comment, :image
  json.url bike_url(bike, format: :json)
end
