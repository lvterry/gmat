#= require url-search-params

$ ->
  $('.customer-service').hide()
  
  exerciseFilters = $('.exercise-filters a')
  selectedFilters = $('.selected-filters a')
  searchParams = new URLSearchParams(location.search)

  exerciseFilters.on 'click', (e) ->
    e.preventDefault()
    return false if this.className is 'selected'
    labelId = $(@).data('value')
    labels = if searchParams.get('labels') then searchParams.get('labels').split(',') else []
    labels.push labelId
    searchParams.set 'labels', labels.join(',')
    searchParams.delete 'page'
    setPathname(searchParams)

  selectedFilters.on 'click', (e) ->
    e.preventDefault()
    labelId = $(@).data('value')
    labels = searchParams.get('labels').split(',')
    newLabels = []
    labels.forEach (item) ->
      newLabels.push(item) if item isnt "#{labelId}"
    searchParams.set 'labels', newLabels
    searchParams.delete 'page'
    setPathname(searchParams)

  $('[name=exclusive]').on 'click', (e) ->
    e.preventDefault()
    if @checked
      searchParams.set 'exclusive', 1
    else
      searchParams.delete 'exclusive'
    setPathname(searchParams)

  setPathname = (searchParams) ->
    pathname = if (location.pathname.indexOf('search') is -1) then "#{location.pathname}/search" else location.pathname
    window.location = "#{pathname}?#{searchParams.toString()}"

  # intercept search form post
  # so that filters are submitted too
  $('.search-bar form').on 'submit', (e)->
    if searchParams.has('labels')
      input = $('<input type="hidden" name="labels" value="' + searchParams.get('labels') + '">')
      $(@).append input


  $('.show-guides').on 'click', (e) ->
    $('.guides').toggle()
  
  initVideoGuide()


initVideoGuide = ()->
  videos = $('.polyv')
  return if videos.length is 0
  element = videos.first()
  player = polyvObject(element).videoPlayer
    'width': '840'
    'height': '573'
    'vid': element.attr('id')