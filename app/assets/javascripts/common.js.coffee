$ = jQuery

$ ->
  $("a.disabled").click(() -> false)
  $("a.with-tooltip").tooltip()
