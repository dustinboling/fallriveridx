class Listing < ActiveRecord::Base
  belongs_to :agent
  belongs_to :broker
  
end