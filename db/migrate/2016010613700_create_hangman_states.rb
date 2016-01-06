class CreateHangmanStates < ActiveRecord::Migration
  def change
    create_table :hangman_states do |t|

      t.timestamps null: false
    end
  end
end
