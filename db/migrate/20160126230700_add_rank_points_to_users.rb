class AddRankPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rank_points, :integer, default: 0
  end
end
