class CreateInsults < ActiveRecord::Migration
  def change
    create_table :insults do |t|
		t.text :insult
    end
  end
end
