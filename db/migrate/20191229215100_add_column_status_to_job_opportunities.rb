class AddColumnStatusToJobOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_column :job_opportunities, :status, :boolean, default:true
  end
end
