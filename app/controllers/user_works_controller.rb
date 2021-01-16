class UserWorksController < ApplicationController
  before_action :authenticate_user!

  def index
    # 閲覧可能の子どもを絞り込み
    user_creator_ids = Family.where(user_id: current_user.id).pluck(:creator_id)
    # クエリパラメータで特定の子どもに絞り込んでいる場合のチェック
    if params[:creator_id]
      if user_creator_ids.include?(params[:creator_id].to_i)
          select_creator_ids =  params[:creator_id]
      else
          redirect_to user_works_path
      end
    else
      select_creator_ids = user_creator_ids
    end

    @user_creators = Creator.where(id: user_creator_ids)
    @user = User.find(current_user.id)

    # 閲覧権限チェック
    user_work_ids = []
    Work.joins("INNER JOIN families ON works.creator_id = families.creator_id")
        .select("works.id AS id, families.id AS family_id, works.scope_id AS scope_id, families.relation_id AS relation_id")
        .where(creator_id: select_creator_ids, families: {user_id: current_user})
        .find_each do |work|
          if work.scope_id == 3 # 一般公開
            user_work_ids << work.id
          else
            user_work_ids << work.id if work.scope.targets.include?(work.relation_id)
          end
        end
        
    @user_works = Work.where(id: user_work_ids).order("date DESC").includes(:creator)
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
