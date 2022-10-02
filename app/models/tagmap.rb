class Tagmap < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end
