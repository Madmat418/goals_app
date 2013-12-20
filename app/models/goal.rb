class Goal < ActiveRecord::Base
  TRUEFALSE = ["true", "false"]
  attr_accessible :complete, :name, :is_private, :user_id
  validates :name, :complete, :user_id, :is_private, :presence => true
  validates :is_private, :complete, :inclusion => { :in => TRUEFALSE }
  before_validation :set_defaults

  def set_defaults
    self.is_private = "false" unless self.is_private == "true"
    self.complete = "false" unless self.complete == "true"
  end

  belongs_to(:user)
end
