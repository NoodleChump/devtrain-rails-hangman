class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps null: false
      t.text :name
    end
  end
end
