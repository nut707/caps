class AddEduProgramIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :edu_program_id, :integer
  end
end
