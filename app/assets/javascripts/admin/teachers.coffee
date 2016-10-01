$ ->
  $('.delete-teacher').on 'click', (e) ->
    e.preventDefault()
    row = $(@).parents('tr')
    id = row.data('id')
    $('#deleteTeacherModal').modal('show')
    $('#deleteTeacherModal .confirm-delete').attr 'data-id', id

  $('#deleteTeacherModal .confirm-delete').on 'click', ->
    id = $(@).attr('data-id')
    $('.teachers-table tr').filter("[data-id=#{id}]").remove()
    $.ajax
      url: "/admin/teachers/#{id}"
      method: 'delete'

  qiniuContainer = $('#qiniu_container')
  avatarContainer = $('#avatar_container')
  avatarHiddenField = $('#teacher_avatar')
  filename = $('.filename')

  filesAdded = (up, files) ->
    qiniuContainer.hide()
    filename.text files[0].name
    filename.parent().removeClass('hidden')

  filesUploaded = (up, file, info) ->
    qiniuContainer.show()
    filename.parent().addClass('hidden')
    avatarHiddenField.attr 'value', "http://#{qiniu_domain}/#{file.name}"
    if avatarContainer.find('img').length > 0
      img = avatarContainer.find('img')
      img.attr 'src', "http://#{qiniu_domain}/#{file.name}?imageView2/1/w/120/h/120"
    else
      html = "<img src='http://#{qiniu_domain}/#{file.name}?imageView2/1/w/120/h/120' width='60' height='60' />"
      avatarContainer.html html

  initQiniu(filesAdded, filesUploaded)
