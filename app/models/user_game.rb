class UserGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :counter_cahce => true

  validates_uniquess_of :user_id, :scope => :game_id
end
