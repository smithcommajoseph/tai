class CreateInsultNouns < ActiveRecord::Migration
  def self.up
    create_table :insult_nouns do |t|
      t.string :noun

      t.timestamps
    end
  end

  def self.down
    drop_table :insult_nouns
  end
end
