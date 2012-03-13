class Broker < ActiveRecord::Base
  has_many :agents
  has_many :listings
  
  validates_presence_of :name
  
end