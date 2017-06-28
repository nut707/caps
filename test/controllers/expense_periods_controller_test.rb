require 'test_helper'

class ExpensePeriodsControllerTest < ActionController::TestCase
  setup do
    @expense_period = expense_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_period" do
    assert_difference('ExpensePeriod.count') do
      post :create, expense_period: { finish: @expense_period.finish, name: @expense_period.name, start: @expense_period.start }
    end

    assert_redirected_to expense_period_path(assigns(:expense_period))
  end

  test "should show expense_period" do
    get :show, id: @expense_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_period
    assert_response :success
  end

  test "should update expense_period" do
    patch :update, id: @expense_period, expense_period: { finish: @expense_period.finish, name: @expense_period.name, start: @expense_period.start }
    assert_redirected_to expense_period_path(assigns(:expense_period))
  end

  test "should destroy expense_period" do
    assert_difference('ExpensePeriod.count', -1) do
      delete :destroy, id: @expense_period
    end

    assert_redirected_to expense_periods_path
  end
end
