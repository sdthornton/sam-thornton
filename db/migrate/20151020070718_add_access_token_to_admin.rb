class AddAccessTokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :access_token, :string
    add_column :admins, :username, :string
  end
end
