class ChangeStatusFieldTypeToParticipants < ActiveRecord::Migration
  def change
    change_column :participants, :status, :integer
  end
end
