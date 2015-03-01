$(document).on 'ajax:success', '#createWatering', (xhr, data, status) ->
  location.reload()

$(document).on 'ajax:error', '#createWatering', (xhr, data, status) ->
  form = $('#new_watering .modal-body')
  div = $('<div id="createWateringErrors" class="alert alert-danger"></div>')
  ul = $('<ul></ul>')
  data.responseJSON.messages.forEach (message, i) ->
    li = $('<li></li>').text(message)
    ul.append(li)

  if $('#createWateringErrors')[0]
    $('#createWateringErrors').html(ul)
  else
    div.append(ul)
    form.prepend(div)
