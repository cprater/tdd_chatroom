class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.string :name
    	t.integer :created_by, source: "User"

      t.timestamps
    end
  end
end
