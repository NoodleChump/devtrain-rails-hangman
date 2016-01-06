class AddNumberOfLivesToHangmanStates < ActiveRecord::Migration
  def change
    add_column :hangman_states, :number_of_lives, :integer
  end
end
