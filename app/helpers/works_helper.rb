module WorksHelper
  # 編集・削除権限チェック
  def edit_permission_check(family)
    return Family.edit_permission_check(family)
  end

  # 公開範囲表示アイコン
  def work_scope_icon(work)
    if work.scope.id == 3
      icon_string = "lock_open"
    else
      icon_string = "lock"
    end
    return raw("<i class='tiny material-icons'>#{icon_string}</i>")
  end
end
