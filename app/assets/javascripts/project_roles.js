$(document).on('ready page:load', function(event) {
  $(document).on("change","#participant_role_id", function (){
    var roleId = $(this).val();
    $.ajax({
      url: "/participants/role_fields_form",
      type: "GET",
      dataType : 'script',
      data: {role_id: roleId}
    })
  });
})