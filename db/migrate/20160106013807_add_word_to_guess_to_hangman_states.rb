class AddWordToGuessToHangmanStates < ActiveRecord::Migration
  def change
    add_column :hangman_states, :word_to_guess, :string
  end
end
