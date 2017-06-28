class Nationality < ActiveRecord::Base
  belongs_to :profile

  validates :name, presence: true, uniqueness: true
end
