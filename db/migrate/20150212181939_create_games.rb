class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :board
      t.integer :turncount
      t.timestamps :null false
    end
  end
end
