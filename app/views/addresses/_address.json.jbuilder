json.extract! address, :id, :user_id, :addressee, :zipcode, :city, :street, :building, :created_at, :updated_at
json.url address_url(address, format: :json)