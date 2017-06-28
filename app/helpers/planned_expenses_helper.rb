module PlannedExpensesHelper
  def planned_expense_collection_for_select
    return @project.planned_expenses.includes(:expense_period,:expense_item).map {|p| [ p.name, p.id ] }
  end
end
