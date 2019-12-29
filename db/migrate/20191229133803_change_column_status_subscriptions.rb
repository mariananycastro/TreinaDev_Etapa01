class ChangeColumnStatusSubscriptions < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriptions, :status, :boolean
  end
end
