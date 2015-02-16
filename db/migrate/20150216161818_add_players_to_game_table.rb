class AddPlayersToGameTable < ActiveRecord::Migration
  def change
  	change_table :games do |t|
  		t.string :player1_id
  		t.string :player2_id
  	end
  end
end
