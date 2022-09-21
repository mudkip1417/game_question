class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
