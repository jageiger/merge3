class Miner < ActiveRecord::Base
  has_one :pool
  
  has_one :join, :dependent => :destroy
  has_one :user, :through => :join
end
