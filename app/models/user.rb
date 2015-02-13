class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  has_many :user_games, foreign_key: "player2_id"
  has_many :following, through: :relationships, source: :followed

  has_many :reverse_user_games, foreign_key: "player1_id",
           class_name: "UserGame"
  has_many :followers, through: :reverse_relationships, source: :follower


end


