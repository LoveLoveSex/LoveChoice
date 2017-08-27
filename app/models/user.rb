class User < ApplicationRecord
  has_many :user_hotels
  has_many :hotels, through: :user_hotels

  enum authority: {normal: 0, administrator: 1, semi_administrator: 2}
  enum sex: {men: 0, women: 1}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :confirmable
end
