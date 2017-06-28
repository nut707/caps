class Course < ActiveRecord::Base
  audited
  belongs_to :project
  belongs_to :edu_program
  has_and_belongs_to_many :languages
  has_many :teachers

  validates :title, presence: true
  validates :duration, :numericality => { :greater_than_or_equal_to => 0 }, :allow_nil => true

  enum lvl: [:bacalavr,:magistr,:phd, :aspirant]
end
