class CreateNationalities < ActiveRecord::Migration
  def change
    create_table :nationalities do |t|
      t.string :name
      t.belongs_to :profile

      t.timestamps null: false
    end
  end
end
