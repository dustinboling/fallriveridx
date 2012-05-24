class AddAuthenticationTokenIndexToUsers < ActiveRecord::Migration
  def up
    add_index :users, :authentication_token
  end
end
