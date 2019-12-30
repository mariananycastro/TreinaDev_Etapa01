class Invitation < ApplicationRecord
  validates :title, presence:true
  validates :message, presence:true
  validates :initial_date, presence:true
  validates :salary, presence:true
  validates :position, presence:true
  validates :expectations, presence:true
  validates :bonus, presence:true
  validates :benefits, presence:true
end

