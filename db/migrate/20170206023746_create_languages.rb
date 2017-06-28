class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :courses_languages, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :course, index: true
    end

    create_table :edu_programs_languages, id: false do |t|
      t.belongs_to :language, index: true
      t.belongs_to :edu_program, index: true
    end
  end
end
