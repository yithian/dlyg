# a user as created by devise

class User < ActiveRecord::Base
  has_many :running_games, :foreign_key => :gm_id
  has_many :plays, :dependent => :destroy
  has_many :games, :through => :plays
  has_many :characters, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable
end
