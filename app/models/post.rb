class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	validates :title, :text, :url, presence: true
  validates :title, uniqueness: true
end
