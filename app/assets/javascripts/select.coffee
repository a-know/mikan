$(document).on 'ready page:load', ->
  $('[data-toggle="select"]').select2({minimumResultsForSearch: 'Infinity'});