class JobOpportunity < ApplicationRecord
    validates :name, presence:true
    validates :description, presence:true
    validates :habilities, presence:true
    validates :salary_range, presence:true
    validates :opportunity_level, presence:true
    validates :end_date_opportunity, presence:true
    validates :region, presence:true

end
