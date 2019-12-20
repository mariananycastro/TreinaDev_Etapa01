class ChangeTypeFieldJobOpportunity < ActiveRecord::Migration[6.0]
  def change
    change_column :job_opportunities, :description, :text
    change_column :job_opportunities, :habilities, :text
    change_column :job_opportunities, :salary_range, :text 
    
  end
end
