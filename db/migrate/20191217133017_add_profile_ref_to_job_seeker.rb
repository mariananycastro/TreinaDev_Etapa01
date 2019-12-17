class AddProfileRefToJobSeeker < ActiveRecord::Migration[6.0]
  def change
    add_reference :job_seekers, :profile, foreign_key: true
  end
end
