class PropertyMedium < ActiveRecord::Base
  belongs_to :listing, :primary_key => :ListingID, :foreign_key => :ListingID
end
