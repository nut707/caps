require 'test_helper'

class ExpenseDocsControllerTest < ActionController::TestCase
  setup do
    @expense_doc = expense_docs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_doc" do
    assert_difference('ExpenseDoc.count') do
      post :create, expense_doc: { cfo: @expense_doc.cfo, comment: @expense_doc.comment, contragent: @expense_doc.contragent, date: @expense_doc.date, number: @expense_doc.number, payment_purpose: @expense_doc.payment_purpose, planned_expense_id: @expense_doc.planned_expense_id, reserve_doc_id: @expense_doc.reserve_doc_id, responsible: @expense_doc.responsible, sum: @expense_doc.sum }
    end

    assert_redirected_to expense_doc_path(assigns(:expense_doc))
  end

  test "should show expense_doc" do
    get :show, id: @expense_doc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_doc
    assert_response :success
  end

  test "should update expense_doc" do
    patch :update, id: @expense_doc, expense_doc: { cfo: @expense_doc.cfo, comment: @expense_doc.comment, contragent: @expense_doc.contragent, date: @expense_doc.date, number: @expense_doc.number, payment_purpose: @expense_doc.payment_purpose, planned_expense_id: @expense_doc.planned_expense_id, reserve_doc_id: @expense_doc.reserve_doc_id, responsible: @expense_doc.responsible, sum: @expense_doc.sum }
    assert_redirected_to expense_doc_path(assigns(:expense_doc))
  end

  test "should destroy expense_doc" do
    assert_difference('ExpenseDoc.count', -1) do
      delete :destroy, id: @expense_doc
    end

    assert_redirected_to expense_docs_path
  end
end
