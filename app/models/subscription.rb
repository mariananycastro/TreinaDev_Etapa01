class Subscription < ApplicationRecord
    belongs_to :job_seeker
    belongs_to :job_opportunity
    belongs_to :hh_answer,  polymorphic: true, optional: true

    has_one :subscription_comment
    
end
