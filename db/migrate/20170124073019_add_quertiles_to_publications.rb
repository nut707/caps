class AddQuertilesToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :quartile_scopus, :integer
    add_column :publications, :quartile_wos, :integer
  end
end
