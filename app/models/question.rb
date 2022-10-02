class Question < ApplicationRecord
  has_one_attached :image
  belongs_to :user, dependent: :destroy
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @question = Question.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @question = Question.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @question = Question.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @question = Question.where("title LIKE?","%#{word}%")
    else
      @question = Question.all
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

end
