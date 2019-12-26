class ChangeTableSubscriptionComments < ActiveRecord::Migration[6.0]
  def change
    rename_table :subscription_comments, :profile_comments
    add_index(:profile_comments, [:profile_id, :headhunter_id], unique: true)

    change_table :profile_comments do |t|
    t.remove :subscription_id, :integer
    t.references :profile, foreign_key: true
    t.references :headhunter, foreign_key: true
    end
  end



end
