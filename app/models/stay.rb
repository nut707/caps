class Stay < ActiveRecord::Base
  audited
  belongs_to :profile
  validate :date_validation

  def date_validation
    if self[:to] < self[:from]
      errors[:to] << "Дата окончания должна быть после даты начала"
      return false
    else
      return true
    end
  end
end
