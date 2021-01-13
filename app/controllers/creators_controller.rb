class CreatorsController < ApplicationController
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
    redirect_to user_works_path(user_id: current_user)
  end

  private

  def creator_params
    params.require(:creator).permit(
      :name,
      :date_of_birth,
      :gender_id
    )
  end
end
