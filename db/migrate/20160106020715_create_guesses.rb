class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|

      t.timestamps null: false
    end
  end
end
