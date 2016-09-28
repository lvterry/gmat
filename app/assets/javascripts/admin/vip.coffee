$ ->
  $('[data-target="#flowModal"]').on 'click', ->
    id = $(@).data('id')
    tr = $(@).parents('tr')
    img = tr.find('.img').find('img').attr('src')
    title = tr.find('.title').text()
    body = tr.find('.body').text()

    $('#flow-id').val(id)
    $('#flow-title').val(title)
    $('#flow-img').val(img)
    $('#flow-body').val(body)

  $('[data-target="#questionModal"]').on 'click', ->
    id = $(@).data('id')
    tr = $(@).parents('tr')
    q = tr.find('.q').text()
    a = tr.find('.a').text()

    $('#question-id').val(id)
    $('#question-q').val(q)
    $('#question-a').val(a)