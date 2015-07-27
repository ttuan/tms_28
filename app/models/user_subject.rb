class UserSubject < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user
  belongs_to :user_course
  has_many :user_tasks, dependent: :destroy
  has_many :activities, dependent: :destroy
  
  accepts_nested_attributes_for :user_tasks, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:status] == "0"}
end
