class AddColumnStarToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :star, :boolean, default:false
  end
end
