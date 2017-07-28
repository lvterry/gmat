$ ->
  $('.js-user-group-filter').on 'change', (e) ->
    window.location = "/admin/users?group=#{this.value}"