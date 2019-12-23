class Invitation < ApplicationRecord
  validates :title, presence:true
  validates :message, presence:true
  
  has_one :subscription, as: :hh_answer
end
