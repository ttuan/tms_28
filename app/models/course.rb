class Course < ActiveRecord::Base
  after_update :create_user_subjects, unless: :check_status

  has_many :activities, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :description, presence: true

  private
  def create_user_subjects
    self.user_courses.each do |user_course|
      self.course_subjects.each do |course_subject|
        UserSubject.create course_id: self.id,
          user_id: user_course.user_id,
          subject_id: course_subject.subject_id,
          user_course_id: user_course.id
      end
    end
  end

  def check_status
    self.status? || self.status.nil?
  end
end
