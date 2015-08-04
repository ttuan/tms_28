class UserCourse < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :user_subjects, dependent: :destroy

  scope :course_active, ->{where active: true}
  before_destroy :send_mail_remove_user

  private
  def send_mail_remove_user
    EmailRemoveUserFromCourse.perform_async self.user_id, self.course_id
  end
end
