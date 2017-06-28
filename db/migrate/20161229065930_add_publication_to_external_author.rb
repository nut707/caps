class AddPublicationToExternalAuthor < ActiveRecord::Migration
  def change
    add_reference :external_authors, :publication, index: true, foreign_key: true
  end
end
