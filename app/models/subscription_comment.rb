class SubscriptionComment < ApplicationRecord
    belongs_to :subscription, dependent: :destroy

end
