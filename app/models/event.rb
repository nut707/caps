class Event < ActiveRecord::Base
  audited
  belongs_to :project
  belongs_to :participant
  validates :title, :start_date, :end_date, :project, :participant, presence: true
  validate :date_validation

  enum status: {
    not_done: 0,
    done: 1
  }

  def date_validation
    if self[:end_date] < self[:start_date]
      errors[:end_date] << "Дата окончания должна быть после даты начала"
      return false
    else
      return true
    end
  end
end
