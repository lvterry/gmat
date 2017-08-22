$ ->
  updateUserMobileForm()
  initCustomerService()

initCustomerService = ->
  cs = $('.customer-service')
  closeBtn = cs.find('.close')
  contact = cs.find('.contact')
  qrcode = cs.find('img')

  contact.hide()
  closeBtn.on 'click', (e)->
    e.preventDefault()
    contact.show()
    qrcode.hide()
    closeBtn.hide()
  
  contact.on 'click', (e)->
    e.preventDefault()
    contact.hide()
    qrcode.show()
    closeBtn.show()


updateUserMobileForm = ->
  form = $('form.edit_user')
  return unless form
  input = form.find('#user_mobile')
  submit = form.find('[type=submit]')
  error = form.find('.error')
  submit.on 'click', (e)->
    e.preventDefault()
    phone = input.val().replace(' ', '')
    # send a request
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
