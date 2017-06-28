class CreateRoleFields < ActiveRecord::Migration
  def change
    create_table :role_fields do |t|
      t.string :name
      t.belongs_to :role, index: true

      t.timestamps null: false
    end
  end
end
