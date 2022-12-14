class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_comments, dependent: :destroy
  has_many :group_users, dependent: :destroy

  validates :user_name, presence: true, uniqueness: true,
                   length: { minimum: 1, maximum: 20 }

  validates :introduction, length: { maximum: 350 }

  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  # 検索方法分岐
  def self.looks(search, word)
    # if search == "perfect_match"
    #   @user = User.where("last_name LIKE?", "#{word}")
    # elsif search == "forward_match"
    #   @user = User.where("last_name LIKE?","#{word}%")
    # elsif search == "backward_match"
    #   @user = User.where("last_name LIKE?","%#{word}")
    # elsif search == "partial_match"
      @user = User.where("user_name LIKE?","%#{word}%")
    #   @user = User.all

  end

  def self.guest
    find_or_create_by!(email: 'guest@guest') do |user|
      user.user_name = 'guest'
      user.telephone_number = '000'
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!
    end
  end
end