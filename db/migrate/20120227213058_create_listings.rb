class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :beds
      t.integer :baths
      t.integer :agent_id

      t.timestamps
    end
  end
end
