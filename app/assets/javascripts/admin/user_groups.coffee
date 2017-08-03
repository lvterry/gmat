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
    if button.text() is '全选'
      button.text '取消全选'
      button.parents('.form-group').find('input').prop 'checked', 'checked'
    else
      button.text '全选'
      button.parents('.form-group').find('input').removeProp 'checked'