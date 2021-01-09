class FamiliesController < ApplicationController
  def new
    @creator = Creator.find(params[:creator_id])
    @family_user_form = FamilyUserForm.new
  end

  def create
    @family_user_form = FamilyUserForm.new(family_user_form_params)
    # User.exists?(email: @family_user_form.user_email)
    if @family_user_form.valid?
      @family_user_form.save
      redirect_to creator_path(params[:creator_id])
    else
      render :new
    end
  end

  private

  def family_user_form_params
    params.require(:family_user_form).permit(
      :relation_id,
      :user_email
    ).merge(
      creator_id: params[:creator_id]
    )
  end
end
