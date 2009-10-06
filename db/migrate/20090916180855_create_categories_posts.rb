class CreateCategoriesPosts < ActiveRecord::Migration
  def self.up
    create_table :categories_posts do |t|
      t.integer :category_id
      t.integer :post_id
    end
  end

  def self.down
    drop_table :categories_posts
  end
end
