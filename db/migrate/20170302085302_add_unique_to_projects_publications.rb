class AddUniqueToProjectsPublications < ActiveRecord::Migration
  def change
    add_index :projects_publications, :publication_id, :unique => true
  end
end
