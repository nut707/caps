//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require bootstrap-sprockets
//= require jquery.ui.all
//= require filterrific/filterrific-jquery
//= require cocoon

//= require autocomplete-rails
//= require_tree .


$(document).on('ready page:load', function(event) {
  //чтобы можно было грузиться на бутсраповские табы
  // Javascript to enable link to tab
  var url = document.location.toString();
  if (url.match('#')) {
    $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
    window.scrollTo(0, 0);
  }

  // Change hash for page-reload
  $('.nav-tabs a').on('shown.bs.tab', function (e) {
    window.location.hash = e.target.hash;
    window.scrollTo(0, 0);
  })
  //end чтобы можно было грузиться на бутсраповские табы

  // мултиселект, выбор по клику
  $('select[multiple="multiple"]').each(function(){    
    var select = $(this), values = {};    
    $('option',select).each(function(i, option){
      values[option.value] = option.selected;        
    }).click(function(event){        
      values[this.value] = !values[this.value];
      $('option',select).each(function(i, option){            
        option.selected = values[option.value];        
      });    
    });
  });


  //table sorting and searching

  $('.table').each(function( index ) {
    th = $(this).find('th')

    not_orderable=[]
    not_orderable.push(jQuery.inArray( $(this).find($('th:contains("Редактировать")'))[0], th ))
    not_orderable.push(jQuery.inArray( $(this).find($('th:contains("Управление")'))[0], th ))
    not_orderable.push(jQuery.inArray( $(this).find($('th:contains("Удалить")'))[0], th ))
    not_orderable.push(jQuery.inArray( $(this).find($('th:contains("Исключить из проекта")'))[0], th ))
    not_orderable.push(jQuery.inArray( $(this).find($('th:contains("Добавить в проект")'))[0], th ))
    
    not_orderable = jQuery.grep(not_orderable, function(a){
      return a != -1 //jQuery.inArray return -1 если ничего не нашел
    })


    $(this).DataTable({
      "paging":   false,
      "info":     false,
      "processing": true,
      "bAutoWidth": false,
      "language": {
         "processing": "Идет обработка...",
         "search": "Поиск",
         "emptyTable": "Нет данных"
      },
      "columnDefs": [
        { "orderable": false, "targets": not_orderable}
      ]
    })
  })
})