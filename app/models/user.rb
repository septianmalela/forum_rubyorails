class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # User Avatar Validation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :forum_threads
  has_many :forum_posts

  has_many :likes
  has_many :forum_threads, through: :likes

  extend FriendlyId
   friendly_id :name, use: :slugged

   private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

end
