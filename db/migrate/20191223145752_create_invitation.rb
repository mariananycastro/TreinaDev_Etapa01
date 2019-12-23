class CreateInvitation < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :title
      t.text :message
      

      t.timestamps

    end
  end
end

