class RoleFieldValue < ActiveRecord::Base
  audited
  belongs_to :participant
  belongs_to :role_field

  validates :participant, :role_field, :value, presence: true

end
