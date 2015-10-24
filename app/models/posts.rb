class Post < ActiveRecord::Base

  validates :title, :content, :url, presence: true
  validates :title, :url, uniqueness: true

  has_many :slugs, dependent: :destroy, inverse_of: :post

  validates_associated :slugs

  before_validation :build_url
  before_save :build_slug

protected

  def build_slug
    if self.url_changed?
      url = self.url
      slug = self.slugs.build(url: url)
    end
  end

  def build_url
    self.url = generate_url
  end

private

  def generate_url
    unless self.title.blank?
      self.url_changed? ? self.url.parameterize.to_s : self.title.parameterize.to_s
    end
  end

end
