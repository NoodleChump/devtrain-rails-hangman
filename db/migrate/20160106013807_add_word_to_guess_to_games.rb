class AddWordToGuessToGames < ActiveRecord::Migration
  def change
    add_column :games, :word_to_guess, :string
  end
end
