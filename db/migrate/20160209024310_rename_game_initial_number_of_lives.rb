class RenameGameInitialNumberOfLives < ActiveRecord::Migration
  def change
    rename_column :games, :number_of_lives, :initial_number_of_lives
  end
end
