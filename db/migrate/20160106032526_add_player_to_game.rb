class AddPlayerToGame < ActiveRecord::Migration
  def change
    add_reference :games, :player, index: true, foreign_key: true
  end
end
