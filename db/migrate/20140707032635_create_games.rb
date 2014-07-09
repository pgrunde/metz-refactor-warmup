class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.timestamps
      t.text :last_roll
      t.integer :total_score
      t.integer :current_score
      t.integer :available_dice
    end
  end
end
