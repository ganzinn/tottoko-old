class CreateCreators < ActiveRecord::Migration[6.1]
  def change
    create_table :creators do |t|
      t.string :name, null: false
      t.string :data_of_birth, null: false
      t.stinrg :gender_id, null: false

      t.timestamps
    end
  end
end
