class Teacher < ActiveRecord::Base
  audited
  belongs_to :course
  belongs_to :nationality

  validates :fio, presence: true
end
