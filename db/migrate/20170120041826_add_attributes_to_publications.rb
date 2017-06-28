class AddAttributesToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :indexed_rinc, :boolean
    add_column :publications, :indexed_scopus, :boolean
    add_column :publications, :indexed_wos, :boolean
  end
end
