class Work < ApplicationRecord

  belongs_to :creator
  has_many_attached :images

end
