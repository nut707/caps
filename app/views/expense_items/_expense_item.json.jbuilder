json.extract! expense_item, :id, :code, :name, :created_at, :updated_at
json.url expense_item_url(expense_item, format: :json)