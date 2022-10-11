class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments
  has_many :group_users

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("last_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("last_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("last_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("last_name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@guest',
                      last_name: 'guest',
                      first_name: 'guest',
                      last_name_kana: 'guest',
                      first_name_kana: 'guest',
                      telephone_number: '000',
                      encrypted_password: 'gggggg') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
