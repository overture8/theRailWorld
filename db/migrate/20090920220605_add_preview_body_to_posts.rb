class AddPreviewBodyToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :preview_body, :text
  end

  def self.down
    remove_column :posts, :preview_body
  end
end
