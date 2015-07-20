class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :active
      t.references :course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
