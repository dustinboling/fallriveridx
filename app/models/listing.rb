class Listing < ActiveRecord::Base
  belongs_to :agent
  belongs_to :broker

  def self.less_than(property, value)
    where("\"#{property}\" < ?", "#{value}")
  end

  def self.greater_than(property, value)
    where("\"#{property}\" > ?", "#{value}")
  end
  
end
