class ExpenseItem < ActiveRecord::Base
  audited
  has_many :planned_expenses
  has_many :expense_docs, through: :planned_expenses
  has_many :reserve_docs, through: :planned_expenses

  validates :code, :name, presence: true
  validates :name, uniqueness: { scope: :code }

  def human_name
    return self.code+ ' - '+self.name
  end
end
