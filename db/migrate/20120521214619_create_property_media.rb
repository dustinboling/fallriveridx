class CreatePropertyMedia < ActiveRecord::Migration
  def change
    create_table :property_media do |t|

      t.timestamps
    end
  end
end
