class Restaurant < ApplicationRecord
  validates_presence_of :name,:tel,:address,:opening_hours,:description
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :like, dependent: :destroy
  has_many :like_users, through: :like, source: :user

  def is_favorited?(user)
  self.favorited_users.include?(user)
end

def is_like?(user)
   self.like_users.include?(user)
 end

end
