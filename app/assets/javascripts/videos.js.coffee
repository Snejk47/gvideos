# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#star').raty
    path: '/img-star'
    score: gon.user_rate
    readOnly: gon.user_rate > 0
    click: (score, evt) ->
      $.post gon.video_rate_path,
        score: score,
        (data) ->
          $('#star').append(data)

