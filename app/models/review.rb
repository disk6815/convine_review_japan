class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true

  has_many :review_categories, dependent: :destroy
  has_many :categories, through: :review_categories
  has_many :review_tastes, dependent: :destroy
  has_many :tastes, through: :review_tastes
  has_many :review_regions, dependent: :destroy
  has_many :regions, through: :review_regions

  has_one_attached :image

  validates :convenience_store_name, presence: true
  validates :product_name, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :price, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: true

  accepts_nested_attributes_for :review_categories, allow_destroy: true
  accepts_nested_attributes_for :review_tastes, allow_destroy: true
  accepts_nested_attributes_for :review_regions, allow_destroy: true
end
