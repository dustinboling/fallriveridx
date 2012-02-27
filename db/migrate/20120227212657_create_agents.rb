class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :license_number
      t.integer :broker_id      
      
      t.timestamps
    end
    add_index :agents, :broker_id
  end
end
