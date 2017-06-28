class CreateExpensePeriods < ActiveRecord::Migration
  def change
    create_table :expense_periods do |t|
      t.date :start
      t.date :finish
      t.string :name
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
