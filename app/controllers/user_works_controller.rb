class UserWorksController < ApplicationController
  before_action :authenticate_user!

  def index
    # 閲覧可能の子どもを絞り込み
    user_creator_ids = Family.where(user_id: current_user.id).pluck(:creator_id)
    # クエリパラメータで特定の子どもに絞り込んでいる場合のチェック
    if params[:creator_id]
      if user_creator_ids.include?(params[:creator_id].to_i)
        select_creator_ids = params[:creator_id]
      else
        redirect_to user_works_path
      end
    else
      select_creator_ids = user_creator_ids
    end

    @user_creators = Creator.where(id: user_creator_ids)

    # 閲覧権限チェック
    user_work_ids = []
    Work.joins('INNER JOIN families ON works.creator_id = families.creator_id')
        .select('works.id AS id, families.id AS family_id, works.scope_id AS scope_id, families.relation_id AS relation_id')
        .where(creator_id: select_creator_ids, families: { user_id: current_user })
        .find_each do |work|
          user_work_ids << work.id if work.scope_id == 3 || work.scope.targets.include?(work.relation_id)
        end

    @user_works = Work.where(id: user_work_ids).order('date DESC').includes(:creator)
  end

  def new
    @work = Work.new
    @user_creators = Creator.where(
      # 関係性がパパ・ママのみ
      id: Family.where(user_id: current_user.id, relation_id: [1, 2]).select(:creator_id)
    )
  end

  def create
    family = Family.find_by(user_id: current_user.id, creator_id: work_params[:creator_id])
    @work = Work.new(work_params)
    if family && [1, 2].include?(family.relation_id) && @work.save
      redirect_to user_works_path(user_id: current_user)
    else
      @user_creators = Creator.where(
        id: Family.where(user_id: current_user.id, relation_id: [1, 2]).select(:creator_id)
      )
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
