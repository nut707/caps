class Role < ActiveRecord::Base
  audited
  validates :name, uniqueness: true, presence: true
  has_many :role_fields
  has_one :participant
end
