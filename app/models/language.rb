class Language < ActiveRecord::Base
  audited
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :edu_programs

  validates :name, uniqueness: true
end
