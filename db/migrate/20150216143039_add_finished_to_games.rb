class AddFinishedToGames < ActiveRecord::Migration
  def change
    add_column :games, :finished, :boolean, default: false, null: false
  end
end
