class Message < ActiveRecord::Base
  
  validates :t, :presence => true
  validates :to, :presence => true
  validates :insult, :presence => true
  
end
