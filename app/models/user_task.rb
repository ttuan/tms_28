class UserTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :user_subject

  before_create :init_relation
  after_create :init_activity 

  private
  def init_relation
    self.user_id = self.user_subject.user_id
    self.subject_id = self.user_subject.subject_id
    self.course_id = self.user_subject.course_id
  end

  def init_activity
    content = Settings.complete_task + self.task.name
    Activity.create! user_id: self.user_id, content: content,
      user_subject_id: self.user_subject_id,
      course_id: self.course_id
  end
end
