class Family < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :relation

  belongs_to :user
  belongs_to :creator

  # 作品の編集・削除権限チェック
  def self.edit_permission_check(family)
    # 編集・削除は「パパ・ママ」のみ
    return family && [1, 2].include?(family.relation_id)
  end
end
