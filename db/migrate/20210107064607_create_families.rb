class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.references :user, foreign_key: true
      t.references :creator, foreign_key: true
      t.string :relation_id, null: false

      t.timestamps
    end
  end
end
