$ = jQuery

_bindAccount = "#signup-bind-account"
_errorMessage = ".error-message"

$.fn.showSignupErrors = (errors, prefix) ->
  for field, error of errors
    if error.length > 0
      $("#" + prefix + "-" + field + "-" + "field").
        addClass("warning").
        find(".help-inline").text(error[0])

$ ->
  _errorMessageNode = $(_errorMessage)
  $(_bindAccount).
    on("ajax:success", (event, resp) ->
      if (resp.success)
        document.location = "/" # redirect to home
      else
        _errorMessageNode.text(resp.error).show())

