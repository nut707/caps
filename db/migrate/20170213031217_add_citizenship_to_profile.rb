class AddCitizenshipToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :citizenship, :string
  end
end
