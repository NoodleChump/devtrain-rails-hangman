class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.integer :sender_id
      t.integer :receiver_id, null: false
      t.integer :game_id
      t.boolean :read, default: false
      t.string :description, default: "No description"

      t.timestamps
    end
  end
end
