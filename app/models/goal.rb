class Goal < ActiveRecord::Base
  attr_accessible :complete, :name, :private, :user_id

  validates :name, :complete, :user_id, :private, :presence => true
  validates :private, :complete, :inclusion => { :in => TRUEFALSE }
  TRUEFALSE = ["true", "false"]
end
