class User < ActiveRecord::Base
  has_many :running_games, :foreign_key => :gm_id
  has_many :plays
  has_many :games, :through => :plays, :uniq => true
  has_many :characters

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
