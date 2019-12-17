class ChangeProfileRefToJobSeeker < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :job_seeker, foreign_key: true
    remove_column :job_seekers, :profile_id
  end
end
