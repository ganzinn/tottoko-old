class Scope  < ActiveHash::Base
  self.data = [
    { id: 1, value: '夫婦のみ' },
    { id: 2, value: '家族みんな' },
  ]

  include ActiveHash::Associations
  has_many :works
end
