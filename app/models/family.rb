class Family < ApplicationRecord
  belongs_to :user
  belongs_to :creator
end