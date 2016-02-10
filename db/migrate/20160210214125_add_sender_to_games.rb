class AddSenderToGames < ActiveRecord::Migration
  def change
    add_column :games, :sender_id, :integer
  end
end
