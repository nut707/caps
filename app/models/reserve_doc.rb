class ReserveDoc < ActiveRecord::Base
  belongs_to :planned_expense
  has_many :expense_docs, dependent: :nullify

  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at", 'comment'] 
  VALIDATABLE_ATTRS = ReserveDoc.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}

  validates_presence_of VALIDATABLE_ATTRS
  validate :date_within_periods_dates, :sum_within_planned_value

  def date_within_periods_dates
    errors[:from] << 'Неправильная дата' if self.from < self.planned_expense.expense_period.start
    errors[:to] << 'Неправильная дата' if self.to > self.planned_expense.expense_period.finish
  end

  def sum_within_planned_value
    errors[:sum] << 'Превышен лимит.' if self.sum > self.planned_expense.balance_res
  end

  def human_name
    return '№ '+self.number+' Сумма: '+self.sum.to_s
  end
end
