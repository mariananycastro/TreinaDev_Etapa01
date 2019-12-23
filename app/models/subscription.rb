class Subscription < ApplicationRecord
    belongs_to :job_seeker
    belongs_to :job_opportunity
    belongs_to :hh_answer,  polymorphic: true, optional: true

    has_one :subscription_comment
    enum status: {not_set: 0, invited: 5, rejected: 10}
    
end
