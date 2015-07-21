class UserCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :user_subjects, dependent: :destroy

  scope :course_active_by_user, ->{where active: true}
end
