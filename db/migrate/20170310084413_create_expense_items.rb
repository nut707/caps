class CreateExpenseItems < ActiveRecord::Migration
  def change
    create_table :expense_items do |t|
      t.string :code
      t.text :name

      t.timestamps null: false
    end
  end
end
