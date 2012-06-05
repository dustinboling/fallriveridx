class Listing < ActiveRecord::Base
  # set primary key to listing ID, necessary 
  # for eager loading of prop_media
  self.primary_key = "ListingID"
  
  belongs_to :agent
  belongs_to :broker

  has_many :property_media, :primary_key => :ListingID, :foreign_key => :ListingID

  def self.less_than(property, value)
    where("\"#{property}\" < ?", "#{value}")
  end

  def self.greater_than(property, value)
    where("\"#{property}\" > ?", "#{value}")
  end
  
end
