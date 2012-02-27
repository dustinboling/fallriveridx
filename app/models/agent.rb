class Agent < ActiveRecord::Base
  belongs_to :broker
  has_many :listings
  
end
