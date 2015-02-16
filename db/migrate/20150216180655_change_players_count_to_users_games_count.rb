class ChangePlayersCountToUsersGamesCount < ActiveRecord::Migration
  def change
    rename_column :games, :players_count, :user_games_count
  end
end
