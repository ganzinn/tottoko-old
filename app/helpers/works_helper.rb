module WorksHelper
  # 編集・削除権限チェック
  def edit_permission_check(family)
    return Family.edit_permission_check(family)
  end
end
