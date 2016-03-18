class Post < ActiveRecord::Base

  CATEGORIES = [
    'faith',
    'tech'
  ]

  validates :title, :body, :url, presence: true
  validates :title, :url, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES,
    message: "%{value} is not a valid category" }
  # validates_associated :slugs

  acts_as_ordered_taggable
  # has_many :slugs, dependent: :destroy, inverse_of: :post

  before_validation :build_url
  # before_save :build_slug

  def build_url
    self.url = generate_url
  end

  def build_slug
    if url_changed?
      self.slugs.build(url: url)
    end
  end

private

  def generate_url
    unless title.blank?
      url_changed? ? url.parameterize.to_s : title.parameterize.to_s
    end
  end

end
