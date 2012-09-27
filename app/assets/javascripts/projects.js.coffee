$ = jQuery

notice = () ->
  $.post "/projects/notice",
    project_id: location.pathname.match(/projects\/(\d+)/)[1],
    (resp) =>
      alert resp.info
      $(".noticed span.num").text(resp.total_noticed)

$ ->
  $(".notice.button").on("click", notice)
