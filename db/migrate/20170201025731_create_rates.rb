class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :name
      t.text :desc
      t.float :exp_val_1y
      t.float :exp_val_2y
      t.float :exp_val_3y

      t.timestamps null: false
    end
  end
end
