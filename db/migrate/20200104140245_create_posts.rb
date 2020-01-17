# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.text :title, null: false
      t.text :content, null: false
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.timestamps null: false
    end
    add_index :posts, %i[user_id created_at]
  end
end
