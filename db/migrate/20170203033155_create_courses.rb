class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :title
      t.belongs_to :project
      t.integer :lvl
      t.text :profile_podgotovki
      t.integer :duration
      t.text :desc

      t.timestamps null: false
    end
  end
end
