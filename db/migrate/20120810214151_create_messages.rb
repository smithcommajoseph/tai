class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.text :message_text
    end
  end
end
