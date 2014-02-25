class CreateSlugs < ActiveRecord::Migration
  def change
    create_table :slugs do |t|
      t.belongs_to :post
      t.string :url

      t.timestamps
    end

    add_index :slugs, :url, unique: true
  end
end
