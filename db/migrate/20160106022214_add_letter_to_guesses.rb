class AddLetterToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :letter, :string
  end
end
