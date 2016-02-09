class AddNumberOfLivesToGames < ActiveRecord::Migration
  def change
    add_column :games, :initial_number_of_lives, :integer
  end
end
