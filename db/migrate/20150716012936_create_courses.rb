class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.boolean :status
      t.date :start_date
      t.integer :day_work

      t.timestamps null: false
    end
  end
end
