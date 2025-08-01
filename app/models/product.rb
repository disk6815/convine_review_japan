class Product < ApplicationRecord
  belongs_to :convenience_store
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  
  validates :name, presence: true
  validates :price, presence: true
end
