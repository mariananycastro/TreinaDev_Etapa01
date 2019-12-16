class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nick_name
      t.string :day_of_birth
      t.string :education_level
      t.text :description
      t.text :experience

      t.timestamps
    end
  end
end
