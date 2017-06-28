class Student < ActiveRecord::Base
  audited
  belongs_to :edu_program, counter_cache: true
  belongs_to :nationality

  validates :fio, presence: true
  validates :ege_mark, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
      
  enum edu_year: ['1','2','3','4']
  enum forma: [:dogovor, :budget]
end
