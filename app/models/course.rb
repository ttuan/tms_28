class Course < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :name, presence: true
  validates :description, presence: true
end
