class CreateScienceBranches < ActiveRecord::Migration
  def change
    create_table :science_branches do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
