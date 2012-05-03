class AddSiteIpAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site_ip_address, :inet
  end
end
