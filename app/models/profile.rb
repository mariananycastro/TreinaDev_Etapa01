class Profile < ApplicationRecord
    validates :name, presence:true, case_sensitive: false
    validates :document, presence:true, uniqueness:true
    validates :nick_name, presence:true
    validates :day_of_birth, presence:true
    validates :education_level, presence:true
    validates :description, presence:true
    validates :experience, presence:true

    belongs_to :job_seeker
    has_many :subscriptions, through: :job_seeker

    def job_seeker_profile
        "#{name} #{document} #{education_level}"
    end

end
