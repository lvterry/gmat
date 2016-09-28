$ ->
  questions = $('.faq > div')
  for q, i in questions
    if i % 2 is 1
      height = $(q).height()
      $(q).prev().height height
