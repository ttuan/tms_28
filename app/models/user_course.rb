class UserCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  scope :course_active_by_user, ->{where "active = 't'"}
end
