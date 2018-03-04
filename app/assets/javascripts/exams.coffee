#= require js.cookie

$ ->

  Cookies.remove('myClock')

  $('[href="#unauthorized"]').on 'click', ->
    layer.msg('您必须先登录才能查看模考内容')

  $('.tabs a').on 'click', ->
    return false if $(@).hasClass('active')
    $('.tabs a').removeClass('active')
    $(@).addClass('active')
    tabs = $('[data-behavior="tab"]')
    tabName = $(@).attr('href').replace('#','')
    tabs.hide()
    tabs.filter('[data-exam-type="' + tabName+ '"]').show()