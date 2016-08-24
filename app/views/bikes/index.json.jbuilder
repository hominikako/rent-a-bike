json.array!(@bikes) do |bike|
  json.extract! bike, :id, :name, :category, :available, :status, :colour, :comment, :image
  json.url bike_url(bike, format: :json)
end
