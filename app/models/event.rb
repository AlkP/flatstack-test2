class Event < ApplicationRecord
  belongs_to :user, optional: true
  
  paginates_per 15
  
  enum period: [ :day, :week, :month, :year ]
  
  scope :current, -> { where("(date > ? and repeat='f') or repeat='t'", DateTime.now.to_date-1.days) }
  scope :by_user, ->(user) { where("user_id = ?", user.id) }
end
