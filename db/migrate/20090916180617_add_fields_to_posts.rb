class AddFieldsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :title, :string
    add_column :posts, :author, :string
    add_column :posts, :prev_body, :text
    add_column :posts, :prev_graphic, :string
  end

  def self.down
    remove_column :posts, :prev_graphic
    remove_column :posts, :prev_body
    remove_column :posts, :author
    remove_column :posts, :title
  end
end
