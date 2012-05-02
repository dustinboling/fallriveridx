class AddAuthenticationTokenAndSiteIpAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string, :default => NULL
    add_column :users, :site_url, :string, :default => NULL
  end
end
