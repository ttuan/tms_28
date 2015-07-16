class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :description
      t.integer :day_work

      t.timestamps null: false
    end
  end
end
