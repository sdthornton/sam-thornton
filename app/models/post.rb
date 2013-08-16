class Post < ActiveRecord::Base
	validates :title, :text, :url, presence: true
  validates :title, uniqueness: true
end
