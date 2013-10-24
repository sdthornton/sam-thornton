class Post < ActiveRecord::Base
	validates :title, :content, :url, presence: true
  validates :title, :url, uniqueness: true

  before_validation :build_url

  def build_url
    self.url = "#{title.parameterize.underscore.to_s}" unless self.title.blank? || self.url.present?
  end
end
