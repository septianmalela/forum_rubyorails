class Like < ApplicationRecord

	belongs_to :forum_thread
	belongs_to :user
end
