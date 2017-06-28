$(document).on('ready page:load', function(event) {
  $(document).on ('change', '#expense_doc_planned_expense_id', function (){
    $.ajax ({
      url: 'reserve_docs_list',
      type: 'GET',
      dataType: 'script',
      data: { planned_expense_id: $("#expense_doc_planned_expense_id option:selected").val() }      
      })
    })         
})