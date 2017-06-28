class ExpenseDoc < ActiveRecord::Base
  belongs_to :planned_expense
  belongs_to :reserve_doc

  NON_VALIDATABLE_ATTRS = ["id", "created_at", "updated_at", 'comment', 'reserve_doc_id'] 
  VALIDATABLE_ATTRS = ExpenseDoc.attribute_names.reject{|attr| NON_VALIDATABLE_ATTRS.include?(attr)}

  validates_presence_of VALIDATABLE_ATTRS
  validates :number, uniqueness: true

  validate :sum_within_planned_value
  validate :sum_within_reserved_sum

  def sum_within_planned_value
    unless self.reserve_doc.present?
      errors[:sum] << 'Превышен лимит планового значения.' if self.sum > self.planned_expense.balance_res
    end
  end

  def sum_within_reserved_sum
    if self.reserve_doc.present?
      errors[:sum] << 'Превышен лимит резерва.' if self.sum > self.reserve_doc.sum
    end
  end
end
