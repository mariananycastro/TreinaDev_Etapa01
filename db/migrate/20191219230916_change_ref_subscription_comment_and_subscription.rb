class ChangeRefSubscriptionCommentAndSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscription_comments, :subscription, index: {unique:true}, foreign_key: true 
    remove_column :subscriptions, :subscription_comment_id
  end
end
