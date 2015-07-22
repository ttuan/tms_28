class UserTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :user_subject

  before_create :init_relation

  private
  def init_relation
    self.user_id = self.user_subject.user_id
    self.subject_id = self.user_subject.subject_id
    self.course_id = self.user_subject.course_id
  end
end
