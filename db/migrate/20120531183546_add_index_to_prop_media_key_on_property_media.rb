class AddIndexToPropMediaKeyOnPropertyMedia < ActiveRecord::Migration
  def change
    add_index :property_media, :PropMediaKey
  end
end
