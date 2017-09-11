$ ->
  $('.js-user-group-filter').on 'change', (e) ->
    window.location = "/admin/users?group=#{this.value}"

  $('.js-check-permission').on 'click', (e)->
    id = $(this).data 'id'
    exerciseId = $('[name="exercise-id"]').val()
    result = $('.js-permission-result')
    result.text '...'
    $.ajax
      url: "/admin/users/#{id}/check_permission"
      data:
        exerciseId: exerciseId
      success: (data)->
        result.text data.permission