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

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(tag_name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_tagmap = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tagmap
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
