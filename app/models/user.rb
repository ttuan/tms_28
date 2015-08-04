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

  private
  def send_email_created
    EmailCreatedAccount.perform_async self.id
  end
end
