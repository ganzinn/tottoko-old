class FamilyCreatorForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment
  attr_accessor :user_id,
                :creator_id,
                :relation_id,
                :creator_name,
                :creator_date_of_birth,
                :creator_gender_id

  def save
    creator = Creator.create(
      name: creator_name,
      date_of_birth: creator_date_of_birth,
      gender_id: creator_gender_id
    )
    Family.create(
      user_id: user_id,
      creator_id: creator.id,
      relation_id: relation_id
    )
  end
end
