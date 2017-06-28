class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :project, index: true
      t.belongs_to :profile, index: true
      t.belongs_to :role, index: true
      t.string :status
    end
  end
end
