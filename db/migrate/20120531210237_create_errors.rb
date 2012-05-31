class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.datetime :time
      t.string :task
      t.string :key

      t.timestamps
    end
  end
end
