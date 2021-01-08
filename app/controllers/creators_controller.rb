class CreatorsController < ApplicationController
  def new
    @family_form = FamilyForm.new
  end

  def create
    @family_form = FamilyForm.new(family_form_params)
    if @family_form.valid?

      # 【Todo】例外処理（トランザクション処理）実装要
      @family_form.save
      # --------------------------------------------------------

      redirect_to root_path
    else
      render :new
    end
  end

  private

  def family_form_params
    params.require(:family_form).permit(
      :creator_name,
      :creator_date_of_birth,
      :creator_gender_id,
      :relation_id,
    ).merge(
      user_id: current_user.id
    )
  end
  


end
