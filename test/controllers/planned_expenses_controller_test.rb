require 'test_helper'

class PlannedExpensesControllerTest < ActionController::TestCase
  setup do
    @planned_expense = planned_expenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planned_expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planned_expense" do
    assert_difference('PlannedExpense.count') do
      post :create, planned_expense: { expense_item: @planned_expense.expense_item, expense_period: @planned_expense.expense_period, value: @planned_expense.value }
    end

    assert_redirected_to planned_expense_path(assigns(:planned_expense))
  end

  test "should show planned_expense" do
    get :show, id: @planned_expense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planned_expense
    assert_response :success
  end

  test "should update planned_expense" do
    patch :update, id: @planned_expense, planned_expense: { expense_item: @planned_expense.expense_item, expense_period: @planned_expense.expense_period, value: @planned_expense.value }
    assert_redirected_to planned_expense_path(assigns(:planned_expense))
  end

  test "should destroy planned_expense" do
    assert_difference('PlannedExpense.count', -1) do
      delete :destroy, id: @planned_expense
    end

    assert_redirected_to planned_expenses_path
  end
end
