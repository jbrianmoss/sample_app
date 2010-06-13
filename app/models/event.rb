class Event < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user

  validates_presence_of :name, :user_id
  validates_length_of   :name, :maximum => 140

  default_scope :order => 'created_at DESC'
end
