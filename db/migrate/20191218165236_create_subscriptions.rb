class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :job_seeker, foreign_key: true
      t.references :job_opportunity, foreign_key: true

      t.timestamps
    end
  end
end
