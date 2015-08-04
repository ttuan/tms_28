class Activity < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :user_subject

  scope :in_day, ->{where "date(created_at) = date('now')"}
end
