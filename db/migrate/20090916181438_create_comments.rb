class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.integer :post_id
      t.string :website
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
