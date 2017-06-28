class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.text :theme
      t.belongs_to :project
      t.text :key_words
      t.text :statement_of_research_problem
      t.text :aims_and_objectives
      t.text :desc_research
      t.text :desc_methods
      t.text :expected_results
      
      t.timestamps null: false
    end

    create_table :researches_science_branches, id: false do |t|
      t.belongs_to :research, index: true
      t.belongs_to :science_branch, index: true
    end

    create_table :activity_directions_researches, id: false do |t|
      t.belongs_to :activity_direction, index: true
      t.belongs_to :research, index: true
    end
  end

end
