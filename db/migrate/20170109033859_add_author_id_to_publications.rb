class AddAuthorIdToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :author_id, :integer
  end
end
