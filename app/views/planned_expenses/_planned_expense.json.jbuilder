json.extract! planned_expense, :id, :value, :expense_period, :expense_item, :created_at, :updated_at
json.url planned_expense_url(planned_expense, format: :json)