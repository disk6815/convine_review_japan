class Region < ApplicationRecord
  has_many :review_regions, dependent: :destroy
  has_many :reviews, through: :review_regions
  
  validates :name, presence: true
end
