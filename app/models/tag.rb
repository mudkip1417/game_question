class Tag < ApplicationRecord

  has_many :tagmaps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :questions, through: :tagmaps , dependent: :destroy

  def self.looks(search, word)

    @tag = Tag.where("tag_name LIKE?","%#{word}%")

  end

end
