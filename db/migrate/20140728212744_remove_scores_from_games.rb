class RemoveScoresFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :total_score, :integer
    remove_column :games, :current_score, :integer
  end
end
