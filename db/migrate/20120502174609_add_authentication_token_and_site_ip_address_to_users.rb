class AddAuthenticationTokenAndSiteIpAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_column :users, :site_url, :text
  end
end
