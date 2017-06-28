class AddExtraFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :experience, :text
    add_column :projects, :resources, :text
  end
end
