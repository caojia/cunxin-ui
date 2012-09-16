$ = jQuery

$.fn.showSignupErrors = (errors, prefix) ->
  for field, error of errors
    if error.length > 0
      $("#" + prefix + "-" + field + "-" + "field").
        addClass("warning").
        find(".help-inline").text(error[0])

