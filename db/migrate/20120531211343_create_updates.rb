class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :unixtime
      t.string :task

      t.timestamps
    end
  end
end
