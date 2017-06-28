class EduProgram < ActiveRecord::Base
  audited
  belongs_to :project
  has_and_belongs_to_many :languages
  has_many :courses
  has_many :students
  
  validates :name, presence: true
  validates :duration, :numericality => { :greater_than_or_equal_to => 0 }, :allow_nil => true

  enum type_pr: [:mag,:asp,:phd, :bac]
  enum forma: [:och,:zaoch]
  enum initial_edu_lvl: [:bacalavr,:magistr]
end
