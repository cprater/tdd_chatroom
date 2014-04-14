class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.belongs_to :room
    	t.string :username
    	t.text :message

    	t.timestamps
    end
  end
end
