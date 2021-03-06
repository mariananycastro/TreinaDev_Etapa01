class Subscription < ApplicationRecord
    validate :end_date_subscription

    belongs_to :job_seeker
    belongs_to :job_opportunity
    belongs_to :hh_answer,  polymorphic: true, optional: true

    def end_date_subscription
        end_date = job_opportunity.end_date_opportunity
        if end_date <= Date.current
            errors.add(:end_date_subscription, 'já encerrada')    
          end  
    end
end
