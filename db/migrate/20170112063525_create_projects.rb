class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :type
      t.string :title

      t.timestamps null: false
    end
    
    add_column :projects, :status, :integer, default: 0, null: false

    add_column :projects, :research_industry, :text
    add_column :projects, :research_area_eduprogram, :text
    add_column :projects, :objective, :text
    add_column :projects, :description, :text
    add_column :projects, :results, :text
    add_column :projects, :attracting_additional_funding, :text
  end
end
