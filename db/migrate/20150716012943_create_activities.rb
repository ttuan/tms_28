class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :content
      t.references :course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :user_subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
