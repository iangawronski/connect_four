class AddPlayersEmail < ActiveRecord::Migration
  def change
    add_column :games, :player1_email, :string
    add_column :games, :player2_email, :string
  end
end
