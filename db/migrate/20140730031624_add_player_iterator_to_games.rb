class AddPlayerIteratorToGames < ActiveRecord::Migration
  def change
    add_column :games, :player_iterator, :integer
  end
end
