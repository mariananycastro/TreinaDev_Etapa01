class ChangeRefSubscriptionCommentAndSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscription_comments, :subscription, index: {unique:true}, foreign_key: true 
  end
end
