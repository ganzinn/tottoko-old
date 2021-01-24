module WorksHelper
  # 編集・削除権限チェック
  def edit_permission_check(family)
    Family.edit_permission_check(family)
  end

  # 公開範囲表示アイコン
  def work_scope_icon(work)
    icon_string = if work.scope.id == 3
                    'lock_open'
                  else
                    'lock'
                  end
    raw("<i class='tiny material-icons'>#{icon_string}</i>")
  end
end
