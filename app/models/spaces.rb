class Space 
	include DataMapper::Resource

	property :id, Serial
	property :name, String, required: true
	property :description, Text
	property :price, Float
	property :available_from, Date
	property :available_to, Date
end