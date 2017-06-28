class CreateReserveDocs < ActiveRecord::Migration
  def change
    create_table :reserve_docs do |t|
      t.references :planned_expense, index: true, foreign_key: true
      t.date :date
      t.string :number
      t.string :cfo
      t.string :contragent
      t.string :payment_purpose
      t.decimal :sum
      t.date :from
      t.date :to
      t.string :responsible
      t.text :comment

      t.timestamps null: false
    end
  end
end
