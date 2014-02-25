class Post < ActiveRecord::Base
	validates :title, :content, :url, presence: true
  validates :title, :url, uniqueness: true

  has_many :slugs, dependent: :destroy, inverse_of: :post

  before_validation :build_url
  before_create :build_slug
  before_update :build_slug

  def build_url
    self.url = normalize_title
  end

  def build_slug
    slug = self.slugs.build
    slug.url = normalize_title
  end

  def normalize_title
    unless self.title.blank?
      self.url || self.title.parameterize.underscore.to_s
    end
  end
end
