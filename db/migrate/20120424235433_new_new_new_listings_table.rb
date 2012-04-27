class NewNewNewListingsTable < ActiveRecord::Migration
  def up
    csv = CSV.read("#{Rails.root.to_s}/property_fields.txt")
    fields = csv.shift.map { |i| i.to_s }
    drop_table :listings
    create_table :listings do |t|
      fields.each do |field|
        t.text :"#{field.gsub(/'/, "")}"
      end
    end
  end

  def down
  end
end
