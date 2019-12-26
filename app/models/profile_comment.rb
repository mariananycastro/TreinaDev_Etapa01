class ProfileComment < ApplicationRecord
    belongs_to :profile
    belongs_to :headhunter

end
