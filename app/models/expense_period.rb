class ExpensePeriod < ActiveRecord::Base
  audited
  belongs_to :project
  has_many :planned_expenses, dependent: :restrict_with_error
  has_many :expense_items, through: :planned_expenses

  validates :start,:finish,:name, presence: true
  validate :date_validation
  validate :date_within_projects_dates


  def date_validation
    if self[:finish] < self[:start]
      errors[:finish] << "Дата окончания должна быть после даты начала"
      return false
    else
      return true
    end
  end

  def date_within_projects_dates
    errors[:start] << 'Неправильная дата' if self.start.year < self.project.from
    errors[:finish] << 'Неправильная дата' if self.finish.year > self.project.to
  end

  def period
    return Russian::strftime(self.start,('%d %B %Y')) +' - '+ Russian::strftime(self.finish,('%d %B %Y'))
  end
end
