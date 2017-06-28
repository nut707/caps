class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :fio
      t.belongs_to :course
      t.integer :birthday_year
      t.belongs_to :nationality

      t.timestamps null: false
    end
  end
end
