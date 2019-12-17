class RemoveProfileRefToJobSeeker < ActiveRecord::Migration[6.0]
  def change
    remove_column :job_seekers, :profile_id_id, :integer
  end
end
