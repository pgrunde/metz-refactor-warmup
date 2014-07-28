class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_name
      t.integer :current_score
      t.integer :total_score
      t.integer :game_id
    end
    add_index :players, :game_id
  end
end
