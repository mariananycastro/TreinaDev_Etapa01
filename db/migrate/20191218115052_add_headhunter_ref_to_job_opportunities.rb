class AddHeadhunterRefToJobOpportunities < ActiveRecord::Migration[6.0]
  def change
    add_reference :job_opportunities, :headhunter, foreign_key: true
  end
end
