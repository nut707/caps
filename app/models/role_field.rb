class RoleField < ActiveRecord::Base
  audited
  belongs_to :role
  has_many :role_field_values

  validates :name, uniqueness: {scope: :role_id}
  validates :role_id, presence: true
end
