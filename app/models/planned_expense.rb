class PlannedExpense < ActiveRecord::Base
  audited
  belongs_to :expense_period
  belongs_to :expense_item
  has_many :reserve_docs, dependent: :restrict_with_error
  has_many :expense_docs, dependent: :restrict_with_error

  validates :value, :expense_period_id, :expense_item_id, presence: true

  def period
    return self.expense_period.period
  end

  def name
    return self.period+' / '+self.expense_item.human_name+' / Планируемая сумма: '+self.value.to_s
  end

  def balance_fact #план-сумма всех расходов
    return self.value-self.expense_docs.sum(:sum)
  end

  def balance_res #план-сумма резерва-сумма нерезврных расходов
    return self.value-self.reserve_docs.sum(:sum)-self.expense_docs.where('reserve_doc_id is ?', nil).sum(:sum)
  end
end
