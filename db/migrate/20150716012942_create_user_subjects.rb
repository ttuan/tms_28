class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.boolean :status
      t.integer :course_id
      t.references :subject, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :user_course, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
