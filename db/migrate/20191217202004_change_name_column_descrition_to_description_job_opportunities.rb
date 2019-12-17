class ChangeNameColumnDescritionToDescriptionJobOpportunities < ActiveRecord::Migration[6.0]
  def change
    change_table :job_opportunities do |t|
      t.rename :descrition, :description
    end
  end
end
