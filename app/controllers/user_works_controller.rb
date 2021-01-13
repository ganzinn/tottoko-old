class UserWorksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    # binding.pry
    user_creator_ids = Family.where(user_id: current_user.id).pluck(:creator_id)
    @user_creators = Creator.where(id: user_creator_ids)
    if params[:creator_id]
      select_creator_ids =  params[:creator_id]
    else
      select_creator_ids = user_creator_ids
    end
    @user_works = Work.where(creator_id: select_creator_ids).includes(:creator)
  end

  def new
    @user_creators = Creator.where(
      id: Family.where(user_id: current_user.id).select(:creator_id)
    )
    @work = Work.new
  end

  def create
    @user_creators = Creator.where(
      id: Family.where(user_id: current_user.id).select(:creator_id)
    )
    @work = Work.new(work_params)
    if @work.save
      redirect_to user_works_path(user_id: current_user)
    else
      render :new
    end
  end

  private

  def work_params
    params.require(:work).permit(
      :date,
      :title,
      :description,
      :scope_id,
      :creator_id,
      images: []
    )
  end
end
