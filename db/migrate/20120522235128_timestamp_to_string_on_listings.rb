class TimestampToStringOnListings < ActiveRecord::Migration
  def change
    change_column :property_media, :PropMediaCreatedTimestamp, :string
  end
end
