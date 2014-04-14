class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.string :name
    	t.integer :created_by, source: "User", default: nil
    	t.text :members
    	t.text :messages

      t.timestamps
    end
  end
end
