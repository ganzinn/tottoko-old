class Creator < ApplicationRecord
  has_many :families
  has_many :users, through: :families
end
