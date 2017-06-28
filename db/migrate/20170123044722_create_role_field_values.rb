class CreateRoleFieldValues < ActiveRecord::Migration
  def change
    create_table :role_field_values do |t|
      t.text :value
      t.belongs_to :role_field, index: true
      t.belongs_to :participant, index: true

      t.timestamps null: false
    end
  end
end
