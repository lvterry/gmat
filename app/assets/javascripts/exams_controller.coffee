#= require jquery

$ ->

  $('.js-next-exercise').on 'click', (e) ->
    e.preventDefault()
    if $('.multi-choice-list input:checked').length is 0
      $('.js-unanwsered').show()
      return false

  $('.js-end-exam').on 'click', (e) ->
    e.preventDefault()
    $('.js-end-exam-dialog').show()

  $('.dialog-close, .dialog .close').on 'click', (e) ->
    $(this).parents('.dialog').hide()