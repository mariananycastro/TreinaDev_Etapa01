class RemoveStatusFromInvitationAndFeedback < ActiveRecord::Migration[6.0]
  def change
    remove_column :feedbacks, :status, :boolean
    remove_column :invitations, :status, :boolean
  end
end
