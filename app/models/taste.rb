class Taste < ApplicationRecord
  has_many :review_tastes, dependent: :destroy
  has_many :reviews, through: :review_tastes

  validates :name, presence: true
end
