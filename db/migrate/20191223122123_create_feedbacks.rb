class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :status, default: 0
      t.text :message
      t.references :subscription, null: false, foreign_key: true, index: {unique:true}

      t.timestamps
    end
  end
end
