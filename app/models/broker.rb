class Broker < ActiveRecord::Base
  has_many :agents
  has_many :listings
  
end
