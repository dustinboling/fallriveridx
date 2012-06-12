class CreateTracts < ActiveRecord::Migration
  def change
    create_table :tracts do |t|
      t.string :name

      t.timestamps
    end
  end
end
