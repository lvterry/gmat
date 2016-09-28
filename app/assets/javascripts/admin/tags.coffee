$ ->
  $(".delete-tag").on 'click', (e)->
    id = $(@).parents('tr').data('id')
    e.preventDefault()
    $('#confirmDelete').attr 'data-id', id
    $('#confirmModal').modal 'show'

  $('#confirmDelete').on 'click', (e)->
    e.preventDefault()
    id = $(@).attr 'data-id'
    $.ajax
      url: "/admin/tags/#{id}"
      method: 'delete'

    $('#confirmModal').on 'hidden.bs.modal', ->
      $('.tags-table tr').filter("[data-id=#{id}]").remove()

    $('#confirmModal').modal 'hide'

  $('.edit-tag').on 'click', (e) ->
    id = $(@).parents('tr').data('id')
    $('#tag_id').val id
    $('#tag_name').val $(@).parents('tr').find('td:first-child').text()

    $('#tagModal .modal-title').text '编辑标签'
    $('#tagModal .edit-tag-prompt').removeClass 'hidden'

  $('.add-tag').on 'click', ->
    $('#tagModal .modal-title').text '添加标签'
    $('#tagModal .edit-tag-prompt').addClass 'hidden'
    $('#tag_id').val ''
