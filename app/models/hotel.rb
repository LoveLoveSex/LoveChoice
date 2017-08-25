class Hotel < ApplicationRecord
  has_many :user_hotels
  has_many :users through: :user_hotels
end
