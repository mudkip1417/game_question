class Group < ApplicationRecord
  has_one_attached :image
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_comments, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
