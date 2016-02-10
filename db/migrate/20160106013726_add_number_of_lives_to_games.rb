class AddNumberOfLivesToGames < ActiveRecord::Migration
  def change
    add_column :games, :number_of_lives, :integer
  end
end
