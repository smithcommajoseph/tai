class CreateInsultAdjectives < ActiveRecord::Migration
  def self.up
    create_table :insult_adjectives do |t|
      t.string :adjective

      t.timestamps
    end
  end

  def self.down
    drop_table :insult_adjectives
  end
end
