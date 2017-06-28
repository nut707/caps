class CreateStays < ActiveRecord::Migration
  def change
    create_table :stays do |t|
      t.belongs_to :profile
      t.date :from
      t.date :to

      t.timestamps null: false
    end
  end
end
