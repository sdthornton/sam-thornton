class Slug < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  belongs_to :post, inverse_of: :slugs
end
