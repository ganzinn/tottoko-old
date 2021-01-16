class UserCreatorsController < ApplicationController
  def new
    @family_creator_form = FamilyCreatorForm.new
  end

  def create
    @family_creator_form = FamilyCreatorForm.new(family_creator_form_params)
    if @family_creator_form.valid?

      # 【Todo】例外処理（トランザクション処理）実装要
      @family_creator_form.save
      # --------------------------------------------------------

      redirect_to user_works_path(user_id: current_user)
    else
      render :new
    end
  end

  def index
    @user_creators = Creator.where(
      id: Family.where(user_id: current_user.id).select(:creator_id)
    )
  end

  private

  def family_creator_form_params
    params.require(:family_creator_form).permit(
      :creator_name,
      :creator_date_of_birth,
      :creator_gender_id,
      :relation_id
    ).merge(
      user_id: current_user.id
    )
  end
end
