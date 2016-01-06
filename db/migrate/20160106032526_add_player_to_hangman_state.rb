class AddPlayerToHangmanState < ActiveRecord::Migration
  def change
    add_reference :hangman_states, :player, index: true, foreign_key: true
  end
end
