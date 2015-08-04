class Activity < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  belongs_to :user_subject

  scope :in_day, ->date{where "date(created_at) = ?", date}
end
