class Family < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :relation

  belongs_to :user
  belongs_to :creator

  # 作品の編集・削除権限チェック
  # こども情報の編集・削除権限チェック
  def self.edit_permission_check(family)
    # 「パパ・ママ」のみ
    return family && [1, 2].include?(family.relation_id)
  end

  # こどもの家族の解除権限チェック
  def self.remove_family_permission_check(user_family, creator_family)
    # パパ・ママは、自身以外解除可能。
    # パパ・ママ以外は自身とのつながりのみ解除可能
    if user_family && [1, 2].include?(user_family.relation_id)
      return user_family.user_id != creator_family.user_id
    else
      return user_family.user_id == creator_family.user_id
    end
  end

  # こどもの家族の追加権限チェック
  def self.add_family_permission_check(family)
    # 「パパ・ママ」のみ
    return family && [1, 2].include?(family.relation_id) 
  end
end
