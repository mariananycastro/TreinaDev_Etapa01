class AddCollumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :document, :string
  end
end
