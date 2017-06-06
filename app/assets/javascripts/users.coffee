$ ->
  updateUserMobileForm()


updateUserMobileForm = ->
  form = $('form.edit_user')
  return unless form
  input = form.find('#user_mobile')
  submit = form.find('[type=submit]')
  error = form.find('.error')
  submit.on 'click', (e)->
    e.preventDefault()
    phone = input.val().replace(' ', '')
    if /^1[34578]\d{9}$/.test(phone)
      # send a request
      error.css 'display', 'none'
      submit.attr('disabled', true).val('正在保存...')
      $.ajax
        url: form.attr('action')
        method: 'PATCH'
        dataType: 'json'
        data:
          user: { mobile: input.val() }
        success: (data) =>
          layer.msg(if data.result then '保存成功' else '保存失败')
          window.location = '/' if data.result
        error: =>
          layer.msg '保存失败'
        complete: =>
          submit.removeAttr('disabled').val('保存手机号')

    else
      error.css 'display', 'block'