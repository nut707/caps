$(document).on('ready page:load', function(event) {

  checkbox = $('[id^="publication_indexed"]')
  

  checkbox.change(function (e) {
    name = $(this).attr('id').split('_')[2]
    enable = $(this).is(':checked')
    $('#citations_'+name+',#publication_quartile_'+name).prop('disabled', !enable)
    
    enable_scopus_wos = $('#publication_indexed_scopus').is(':checked')&&$('#publication_indexed_wos').is(':checked')
    $('#citations_scopus_wos').prop('disabled', !enable_scopus_wos)

    // if (enable == false){
    //   $('#citations_'+name).prop('value','')
    //   $('#publication_quartile_'+name).prop('value','')
    // }
  });
});