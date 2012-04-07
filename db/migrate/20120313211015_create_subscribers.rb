class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.boolean :active
      t.text :website_url
      t.string :website_ip

      t.timestamps
    end
  end
end
