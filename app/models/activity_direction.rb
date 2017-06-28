class ActivityDirection < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_and_belongs_to_many :researches
  has_and_belongs_to_many :projects
  
  default_scope { order(name: :asc) }
end
