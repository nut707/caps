json.extract! expense_period, :id, :start, :finish, :name, :created_at, :updated_at
json.url expense_period_url(expense_period, format: :json)