class FamilyUserForm
  include ActiveModel::Model
  attr_accessor :user_id,
                :user_email,
                :creator_id,
                :relation_id

  def save
    user_id = User.select(:id).find_by(email: user_email).id
    Family.create(
      user_id: user_id,
      creator_id: creator_id,
      relation_id: relation_id
    )
  end
end
