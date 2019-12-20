class Subscription < ApplicationRecord
    belongs_to :job_seeker
    belongs_to :job_opportunity

    has_many :job_seekers
    has_many :profiles, through: :job_seeker
    has_one :subscription_comment, dependent: :destroy

end
