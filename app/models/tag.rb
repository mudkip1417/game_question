class Tag < ApplicationRecord

  has_many :tagmaps, dependent: :destroy
  has_many :questions, through: :tagmaps

end
