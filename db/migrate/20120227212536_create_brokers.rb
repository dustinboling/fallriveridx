class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|
      t.string :name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.string :license_number

      t.timestamps
    end
  end
end
