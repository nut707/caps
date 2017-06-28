class CreateJoinTableProjectPublication < ActiveRecord::Migration
  def change
    create_join_table :projects, :publications do |t|
      t.index [:project_id, :publication_id], unique: true
      t.index [:publication_id, :project_id], unique: true
    end
  end
end
