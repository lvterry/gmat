token = $('meta[name="csrf-token"]').attr('content')

$.ajaxSetup
  data:
    authenticity_token: $('meta[name="csrf-token"]').attr('content')
