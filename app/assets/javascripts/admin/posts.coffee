$ ->
  $('.delete-post').on 'click', (e) ->
    e.preventDefault()
    if window.confirm('确认删除吗？')
      $(@).parents('tr').remove()
      $.ajax
        url: $(@).attr('href')
        method: 'delete'
    false

  $('.delete-attachment').on 'click', (e) ->
    e.preventDefault()
    row = $(@).parents('tr')
    if window.confirm('确认删除吗？')
      $.ajax
        url: $(@).attr('href')
        method: 'delete'
        success: (data) ->
          row.remove() if data.success is 1

  store = (file) ->
    console.log(file)
    $.ajax
      url: '/admin/attachments'
      method: 'post'
      data:
        attachment:
          original_name: file.name
          new_name: file.name
          size: file.origSize
          attachment_type: file.type
          url: "http://#{qiniu_domain}/#{file.name}"
          post_id: $('#post-id').val()
      success: (data) ->
        console.log(data.success)

  filesUploaded = (up, file, info) ->
    html = "<tr><td><a href='http://#{qiniu_domain}/#{file.name}'>#{file.name}</a></td><td><a href='#' class='delete-attachment'>&times;</a></td>"
    $('.files tr').filter(':last').remove()
    $('.files tbody').append html
    $('#qiniu_container').show()
    store(file)

  filesAdded = (up, files) ->
    $('#qiniu_container').hide()
    plupload.each files, (file) ->
      html = "<tr><td>#{file.name}</td><td><img src='/assets/loading.gif'/></td>"
      $('.files tbody').append html

  initQiniu(filesAdded, filesUploaded)

