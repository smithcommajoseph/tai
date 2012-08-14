class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :insult_id
      t.integer :user_id
      t.string :target_name
      t.timestamps
    end
  end
end