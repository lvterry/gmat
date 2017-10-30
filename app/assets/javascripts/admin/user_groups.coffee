$ ->
  $('.js-remove-user').on 'click', (e) ->
    e.preventDefault()
    groupId = $(@).parents('table').data('group')
    userId = $(@).data('id')
    $.ajax
        url: "/admin/user_groups/#{groupId}/remove_user"
        method: 'post'
        data:
          user_id: userId
        success: (data) ->
          if data.success is 1
            layer.msg '操作成功'
            setTimeout ->
              window.location.reload()
            , 1000
          else
            layer.msg '操作失败'
        error: ->
          layer.msg '操作失败'

  $('.js-select-all').on 'click', (e) ->
    e.preventDefault()
    button = $(this)
    if button.text() is '选中全部'
      button.text '取消选中全部'
      button.parents('.form-group').find('input').prop 'checked', 'checked'
    else
      button.text '选中全部'
      button.parents('.form-group').find('input').removeProp 'checked'

  $('.js-select-all-text').on 'click', (e) ->
    e.preventDefault()
    button = $(this)
    if button.text() is '选中全部文字'
      button.text '取消选中全部文字'
      button.parents('.form-group').find('input[name="user_group[permissions][][label_id]"]').prop 'checked', 'checked'
    else
      button.text '选中全部文字'
      button.parents('.form-group').find('input[name="user_group[permissions][][label_id]"]').removeProp 'checked'


  # delete user group
  modal = $('#confirmUserGroupDeletion')
  confirmButton = modal.find('.js-confirm')

  $('.js-delete-user-group').on 'click', (e) ->
    id = $(@).parents('tr').data('id')
    e.preventDefault()
    confirmButton.attr 'data-id', id
    modal.modal 'show'

  confirmButton.on 'click', (e)->
    e.preventDefault()
    id = $(@).attr 'data-id'
    $.ajax
      url: "/admin/user_groups/#{id}"
      method: 'delete'

    modal.on 'hidden.bs.modal', ->
      $('.user-group-table tr').filter("[data-id=#{id}]").remove()

    modal.modal 'hide'

  # get qrcode
  qrcodeModal = $('#qrcode_modal')
  $('.js-get-qrcode').on 'click', (e) ->
    e.preventDefault()
    id = $(@).parents('tr').data('id')
    url = "#{window.location.origin}/user_groups/#{id}/join"
    $('#qrcode-container').empty()
    qrcodeModal.find('.js-group-name').text $(@).parents('tr').find('.group-name').text()
    new QRCode(document.getElementById("qrcode-container"), url)
    qrcodeModal.modal 'show'