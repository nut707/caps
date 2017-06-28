require 'test_helper'

class ReserveDocsControllerTest < ActionController::TestCase
  setup do
    @reserve_doc = reserve_docs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reserve_docs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserve_doc" do
    assert_difference('ReserveDoc.count') do
      post :create, reserve_doc: { cfo,: @reserve_doc.cfo,, comment: @reserve_doc.comment, contragent,: @reserve_doc.contragent,, date,: @reserve_doc.date,, from,: @reserve_doc.from,, number,: @reserve_doc.number,, payment_purpose,: @reserve_doc.payment_purpose,, planned_expense_id,: @reserve_doc.planned_expense_id,, responsible,: @reserve_doc.responsible,, sum,: @reserve_doc.sum,, to,: @reserve_doc.to, }
    end

    assert_redirected_to reserve_doc_path(assigns(:reserve_doc))
  end

  test "should show reserve_doc" do
    get :show, id: @reserve_doc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reserve_doc
    assert_response :success
  end

  test "should update reserve_doc" do
    patch :update, id: @reserve_doc, reserve_doc: { cfo,: @reserve_doc.cfo,, comment: @reserve_doc.comment, contragent,: @reserve_doc.contragent,, date,: @reserve_doc.date,, from,: @reserve_doc.from,, number,: @reserve_doc.number,, payment_purpose,: @reserve_doc.payment_purpose,, planned_expense_id,: @reserve_doc.planned_expense_id,, responsible,: @reserve_doc.responsible,, sum,: @reserve_doc.sum,, to,: @reserve_doc.to, }
    assert_redirected_to reserve_doc_path(assigns(:reserve_doc))
  end

  test "should destroy reserve_doc" do
    assert_difference('ReserveDoc.count', -1) do
      delete :destroy, id: @reserve_doc
    end

    assert_redirected_to reserve_docs_path
  end
end
