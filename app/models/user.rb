class User < ApplicationRecord
  validates_presence_of :name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         mount_uploader :avatar, FaceImageUploader
         has_many :comments, dependent: :restrict_with_error
         has_many :restaurants, through: :comments
         has_many :favorites, dependent: :destroy
         has_many :favorited_restaurants, through: :favorites, source: :restaurant
         has_many :like, dependent: :destroy
         has_many :like_restaurants, through: :like, source: :restaurant
         has_many :followships, dependent: :destroy
         has_many :followings, through: :followships
         has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
         has_many :followers, through: :inverse_followships, source: :user
         has_many :friendships, dependent: :destroy
         has_many :friends, through: :friendships
         has_many :inverse_friend , class_name: "Friendship", foreign_key: "friend_id"
         has_many :inverse_friends , through: :inverse_friend, source: :user
         def admin?
           self.role == "admin"
         end

         def following?(user)
           self.followings.include?(user)
         end
         def friend?(user)
         self.friends.include?(user)
        end

        def all_friends
          all_friends = self.friends + self.inverse_friends
          return all_friends.uniq
        end



end
