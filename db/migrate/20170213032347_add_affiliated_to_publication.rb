class AddAffiliatedToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :affiliated_fefu, :boolean
  end
end
