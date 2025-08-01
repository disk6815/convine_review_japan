class ReviewTaste < ApplicationRecord
  belongs_to :review
  belongs_to :taste
end
