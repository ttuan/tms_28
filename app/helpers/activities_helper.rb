module ActivitiesHelper
  def create_activity user_id, content, user_subject_id = nil, course_id = nil
    Activity.create! user_id: user_id, content: content,
      user_subject_id: user_subject_id, course_id: course_id
  end
end
