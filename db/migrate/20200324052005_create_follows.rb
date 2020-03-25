# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :followee
      t.timestamps null: false
    end
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :followee_id
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
