module FamiliesHelper
  # こどもの家族の解除権限チェック
  def remove_family_permission_check(user_family, creator_family)
    return Family.remove_family_permission_check(user_family, creator_family)
  end

  # こどもの家族の追加権限チェック
  def add_family_permission_check(family)
    return Family.add_family_permission_check(family)
  end
end
