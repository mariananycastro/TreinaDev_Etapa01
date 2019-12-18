class AddIndexToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_index(:subscriptions, [:job_seeker_id, :job_opportunity_id], unique: true)
  end
end
