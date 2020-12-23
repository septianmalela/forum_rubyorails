class ForumThread < ApplicationRecord

	belongs_to :user
	has_many :forum_posts

	has_many :likes
	has_many :users, through: :likes

	validates :title, presence: true, length: {maximum: 50}
	validates :content, presence: true

	def liked_by_user(user)
		likes.find_by(user: user)&.like || false
	end

	def accept_status_by_admin(user)
	    ForumThread.find_by(user: user)&.status || false
	end	

	extend FriendlyId
  		friendly_id :title, use: :slugged

end
