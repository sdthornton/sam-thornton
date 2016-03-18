class AddIndexToPostCategory < ActiveRecord::Migration
  def change
    add_index :posts, :category
  end
end
