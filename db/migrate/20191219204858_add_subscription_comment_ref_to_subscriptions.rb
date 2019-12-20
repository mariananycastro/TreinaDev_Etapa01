class AddSubscriptionCommentRefToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :subscription_comment, index: {unique:true}, foreign_key: true 
  end
end
