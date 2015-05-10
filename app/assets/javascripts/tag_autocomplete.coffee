$(document).on 'ready page:load', ->
  $('.form-group #mikanz_tag').tagit
    fieldName:     'mikanz[tag_list]'
    singleField:   true
    availableTags: gon.available_tags
