class User < ApplicationRecord
  has_many :user_hotels
  has_many :users, through: :user_hotels

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :confirmable
end
