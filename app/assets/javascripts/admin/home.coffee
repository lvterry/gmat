$ ->
  $('.delete-meeting, .delete-slide').on 'click', (e) ->
    e.preventDefault()
    if window.confirm('确认删除吗？')
      $(@).parents('tr').remove()
      $.ajax
        url: $(@).attr('href')
        method: 'delete'
    false

  $('.datetime').datetimeEntry
    datetimeFormat: 'Y-O-D H:M'
    spinnerImage: ''