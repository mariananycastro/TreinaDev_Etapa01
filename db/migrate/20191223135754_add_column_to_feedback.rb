class AddColumnToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :title, :string
  end
end
