class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.boolean :status
      t.integer :course_id
      t.integer :subject_id
      t.references :task, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :user_subject, index: true, foreign_key: true    

      t.timestamps null: false
    end
  end
end
