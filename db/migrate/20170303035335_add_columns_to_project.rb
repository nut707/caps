class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :from, :integer
    add_column :projects, :to, :integer
  end
end
