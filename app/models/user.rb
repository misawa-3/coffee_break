class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # Profile image method
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # Search method
  def self.looks(search, word)
    if search == "perfect_match"
      where("name LIKE ?", word)
    elsif search == "partial_match"
      where("name LIKE ?", "%#{word}%")
    else
      all
    end
  end

  # Follow and unfollow methods
  def following?(other_user)
    active_relationships.exists?(followed_id: other_user.id)
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  # User status management
  enum status: { active: 0, deactivated: 1, frozen: 2 }
  scope :active_users, -> { where(status: :active) }

  def status_i18n
    I18n.t("activerecord.attributes.user.statuses.#{status}")
  end

  def deactivate!
    update(status: :deactivated)
  end

  def freeze!
    update(status: :frozen)
  end

  def reactivate!
    update(status: :active)
  end
  
end