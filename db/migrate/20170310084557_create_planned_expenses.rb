class CreatePlannedExpenses < ActiveRecord::Migration
  def change
    create_table :planned_expenses do |t|
      t.references :expense_period, index: true, foreign_key: true
      t.references :expense_item, index: true, foreign_key: true
      t.decimal :value

      t.timestamps null: false
    end
  end
end
