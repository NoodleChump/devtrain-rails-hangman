class AddHangmanStateToGuesses < ActiveRecord::Migration
  def change
    add_reference :guesses, :hangman_state, index: true, foreign_key: true
  end
end
