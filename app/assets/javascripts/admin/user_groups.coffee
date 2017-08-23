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