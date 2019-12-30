class AddColumnsToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :initial_date, :date
    add_column :invitations, :salary, :integer
    add_column :invitations, :position, :string
    add_column :invitations, :expectations, :text
    add_column :invitations, :bonus, :text
    add_column :invitations, :benefits, :text
  end
end
