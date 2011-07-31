class UpdateTweetsTbl < ActiveRecord::Migration
  def self.up
    rename_table :tweets, :messages
    add_column :messages, :n, :string
  end

  def self.down
    remove_column :messages, :n
    rename_table :messages, :tweets 
  end
end
