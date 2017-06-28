class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.integer :year
      t.string :url
      t.string :title_izdanie
      t.string :url_izdanie
      t.bigint :issn
      t.bigint :isbn
      t.integer :citations_rinc
      t.integer :citations_scopus
      t.integer :citations_wos
      t.integer :citations_scopus_wos

      t.timestamps null: false
    end
    add_index :publications, :title
  end
end
