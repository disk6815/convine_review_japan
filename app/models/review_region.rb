class ReviewRegion < ApplicationRecord
  belongs_to :review
  belongs_to :region
end
