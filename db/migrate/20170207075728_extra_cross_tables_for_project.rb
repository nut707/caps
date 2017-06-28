class ExtraCrossTablesForProject < ActiveRecord::Migration
  def change
    remove_column :projects, :research_industry
    remove_column :projects, :research_area_eduprogram
  end

  create_join_table(:projects, :science_branches)
  create_join_table(:activity_directions,:projects)

  # create_join_table :projects, :publications do |t|
  #   t.index [:project_id, :publication_id], unique: true
  #   t.index [:publication_id, :project_id], unique: true
  # end

  # create_table :courses_languages, id: false do |t|
  #   t.belongs_to :language, index: true
  #   t.belongs_to :course, index: true
  # end

  # create_table :edu_programs_languages, id: false do |t|
  #   t.belongs_to :language, index: true
  #   t.belongs_to :edu_program, index: true
  # end


end
