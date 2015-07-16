class Course < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
end
