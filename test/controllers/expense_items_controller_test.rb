require 'test_helper'

class ExpenseItemsControllerTest < ActionController::TestCase
  setup do
    @expense_item = expense_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_item" do
    assert_difference('ExpenseItem.count') do
      post :create, expense_item: { code: @expense_item.code, name: @expense_item.name }
    end

    assert_redirected_to expense_item_path(assigns(:expense_item))
  end

  test "should show expense_item" do
    get :show, id: @expense_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_item
    assert_response :success
  end

  test "should update expense_item" do
    patch :update, id: @expense_item, expense_item: { code: @expense_item.code, name: @expense_item.name }
    assert_redirected_to expense_item_path(assigns(:expense_item))
  end

  test "should destroy expense_item" do
    assert_difference('ExpenseItem.count', -1) do
      delete :destroy, id: @expense_item
    end

    assert_redirected_to expense_items_path
  end
end
