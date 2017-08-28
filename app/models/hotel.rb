class Hotel < ApplicationRecord
  has_many :user_hotels
  has_many :users, through: :user_hotels

  validates :name,    length: { maximum: 20 }
  validates :summary, presence: true

  class << self
    def search(word)
      self.where("name like '%#{word}%'")
    end
  end
end
