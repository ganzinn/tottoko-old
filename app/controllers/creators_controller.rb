class CreatorsController < ApplicationController
  def new
    @family_creator_form = FamilyCreatorForm.new
  end

  def create
    @family_creator_form = FamilyCreatorForm.new(family_creator_form_params)
    if @family_creator_form.valid?

      # 【Todo】例外処理（トランザクション処理）実装要
      @family_creator_form.save
      # --------------------------------------------------------

      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @user_creators = Creator.where(
      id: Family.where(user_id: current_user.id).select(:creator_id)
    )
  end

  def show
    @creator = Creator.find(params[:id])
    @creator_families = Family.where(creator_id: params[:id]).includes(:user)
  end

  def edit
    @creator = Creator.find(params[:id])
  end

  def update
    @creator = Creator.find(params[:id])
    if @creator.update(creator_params)
      redirect_to creator_path(@creator)
    else
      render :edit
    end
  end

  def destroy
    @creator = Creator.find(params[:id])
    @creator.destroy
    redirect_to root_path
  end

  private

  def family_creator_form_params
    params.require(:family_creator_form).permit(
      :creator_name,
      :creator_date_of_birth,
      :creator_gender_id,
      :relation_id,
    ).merge(
      user_id: current_user.id
    )
  end

  def creator_params
    params.require(:creator).permit(
      :name,
      :date_of_birth,
      :gender_id,
    )
  end
end
