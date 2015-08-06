class User < ActiveRecord::Base
  after_create :send_email_created

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :courses, through: :user_courses
  
  mount_uploader :avatar, AvatarUploader

  scope :avaiable_to_add, ->course_id{where "id NOT IN (SELECT user_id FROM User_Courses WHERE active = 'true' 
    AND course_id != ?)", course_id}
  scope :supervisors, ->{where supervisor: true}

  def self.report_in_day
    self.supervisors.each do |supervisor|
      EmailReportInDay.perform_async supervisor.id
    end
  end

  scope :list_supervisor, ->course_id{where "supervisor = ? AND users.id IN
    (SELECT user_id FROM User_Courses WHERE course_id = ?)", true, course_id}

  private
  def send_email_created
    EmailCreatedAccount.perform_async self.id
  end
end
