class CreateJobOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :job_opportunities do |t|
      t.string :name
      t.string :descrition
      t.string :habilities
      t.integer :salary_range
      t.integer :opportunity_level
      t.date :end_date_opportunity
      t.string :region

      t.timestamps
    end
  end
end
