class AddGameToGuesses < ActiveRecord::Migration
  def change
    add_reference :guesses, :game, index: true, foreign_key: true
  end
end
