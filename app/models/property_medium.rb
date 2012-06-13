class PropertyMedium < ActiveRecord::Base
  # self.primary_key = "ListingID"

  belongs_to :listing, :primary_key => :ListingID, :foreign_key => :ListingID
end
