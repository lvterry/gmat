$ ->
  $('.delete-course').on 'click', (e) ->
    e.preventDefault()
    if window.confirm('确认删除吗？')
      $(@).parents('tr').remove()
      $.ajax
        url: $(@).attr('href')
        method: 'delete'
    false

  qiniuContainer = $('#qiniu_container')
  imgContainer = $('#img_container')
  imgHiddenField = $('#course_img_url')
  filename = $('.filename')

  filesAdded = (up, files) ->
    qiniuContainer.hide()
    filename.text files[0].name
    filename.parent().removeClass('hidden')

  filesUploaded = (up, file, info) ->
    qiniuContainer.show()
    filename.parent().addClass('hidden')
    imgHiddenField.attr 'value', "http://#{qiniu_domain}/#{file.name}"
    if imgContainer.find('img').length > 0
      img = imgContainer.find('img')
      img.attr 'src', "http://#{qiniu_domain}/#{file.name}?imageView2/1/w/240/h/145"
    else
      html = "<img src='http://#{qiniu_domain}/#{file.name}?imageView2/1/w/240/h/145' width='240' height='145' /><a href='#'>Delete</a>"
      imgContainer.html html

  initQiniu(filesAdded, filesUploaded)