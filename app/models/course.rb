class Course < ActiveRecord::Base
  after_update :create_user_subjects, unless: :check_status
  before_update :send_mail_assign
  before_update :init_start_date, unless: :check_status
  before_save :init_day_work

  has_many :activities, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :users, through: :user_courses

  validates :name, presence: true
  validates :description, presence: true

  scope :course_active, ->{where status: true}
  
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

  def send_mail_assign
    EmailAssignTrainees.perform_async self.id
  end

  def init_start_date
    self.start_date = Date.today
    self.users.each do |user|
      Delayed::Job.enqueue ReportAdminBeforeFinishJob.new(self.id, user.id),
        run_at: number_delay_day.days.from_now if user.supervisor?
    end
  end

  def number_delay_day
    self.day_work - Settings.delay_days
  end

  def init_day_work
    self.day_work = self.subjects.map(&:day_work).sum
  end
end
