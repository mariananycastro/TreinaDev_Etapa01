class ChangeTypeFieldProfile < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :day_of_birth, :date 
  end
end
