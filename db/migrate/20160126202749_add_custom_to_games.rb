class AddCustomToGames < ActiveRecord::Migration
  def change
    add_column :games, :custom, :boolean, default: false
  end
end
