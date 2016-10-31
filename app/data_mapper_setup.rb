require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/user'
require_relative 'models/spaces'
require_relative 'models/requests'

DataMapper.setup(:default, "postgres://localhost/bnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
