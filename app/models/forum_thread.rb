class ForumThread < ApplicationRecord

	belongs_to :user
	has_many :forum_posts

	has_many :likes
	has_many :users, through: :likes

	validates :title, presence: true, length: {maximum: 50}
	validates :content, presence: true

end
