class CreateJoinTableProfilePublication < ActiveRecord::Migration
  def change
    create_join_table :profiles, :publications do |t|
      t.index [:profile_id, :publication_id]
      t.index [:publication_id, :profile_id], :unique => true
    end
  end
end
