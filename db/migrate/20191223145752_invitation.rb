class Invitation < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.boolean :status
      t.text :message
      t.string :title
      t.bigint :hh_answer_id
      t.string :hh_answer_type

      t.timestamps

    end

    add_index :invitations, [:hh_answer_type, :hh_answer_id]

    change_table :feedbacks do |t|
      t.remove :subscription_id, :integer
      t.change :status, :boolean 
      t.bigint :hh_answer_id
      t.string :hh_answer_type
    end

    add_index :feedbacks, [:hh_answer_type, :hh_answer_id]
  end
end
