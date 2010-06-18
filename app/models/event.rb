class Event < ActiveRecord::Base
  attr_accessible :name, :description, :start_time, :end_time, :stop_sales, :quantity, :price, :currency, :max_tix

  belongs_to :user

  validates_presence_of :name, :description, :user_id
  validates_length_of   :name, :maximum => 40
  validates_length_of   :description, :maximum => 300

  default_scope :order => 'start_time ASC'
end
