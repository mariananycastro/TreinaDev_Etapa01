class Subscription < ApplicationRecord
    belongs_to :job_seeker
    belongs_to :job_opportunity

    has_many :profiles, through: :job_seeker
    has_one :subscription_comment
end