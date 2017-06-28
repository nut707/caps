class CreateEduPrograms < ActiveRecord::Migration
  def change
    create_table :edu_programs do |t|
      t.belongs_to :project
      t.text :name
      t.integer :type_pr
      t.integer :forma
      t.text :profile_podgotovki
      t.text :lanuages
      t.text :code_spec
      t.text :second_diplom_univer
      t.integer :initial_edu_lvl
      t.text :other_requirements
      t.integer :price
      t.integer :duration
      t.text :degree
      t.date :date_start_enrolment
      t.date :date_start_education

      t.timestamps null: false
    end
  end
end
