class Subscription < ApplicationRecord
    belongs_to :job_seeker
    belongs_to :job_opportunity

end
