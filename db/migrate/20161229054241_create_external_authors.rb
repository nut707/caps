class CreateExternalAuthors < ActiveRecord::Migration
  def change
    create_table :external_authors do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name

      t.timestamps null: false
    end
  end
end
