$ = jQuery

_signinLink = ".signin-modal-link"
$ ->
  $(_signinLink).click (event) ->
    $($(this).data("target")).modal "show"
