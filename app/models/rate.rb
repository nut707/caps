class Rate < ActiveRecord::Base
  audited
  validates :name, presence: true, uniqueness: true
end
