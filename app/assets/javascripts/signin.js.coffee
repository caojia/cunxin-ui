$ = jQuery

_signinLink = ".signin-modal-link"

_cookieMap =
  id: "_cunxin_id"
  name: "_cunxin_name"
  thumb: "_cunxin_thumb"

_signinForm = "#signin-form"
_signinModal = "#signin-modal"
_signinText = ".signin-required-text"
_signinError = ".signin-error-message"

_homeSignupForm = "#home-signup-form"

# check login
checkLogin = (login_cb, logout_cb) ->
  id = $.cookie(_cookieMap.id)
  if id > 0
    login_cb && login_cb(id, $.cookie(_cookieMap.name), $.cookie(_cookieMap.thumb))
  else
    logout_cb && logout_cb()

loginCallback = (id, name, thumb) ->
  nav = $("#login-nav")
  if thumb
    $(".loggedin.user-thumb img", nav).attr("src", thumb).toggleClass("hidden")
  if name
    $(".loggedin.user-name a", nav).text(name)

  $(".loggedin, .anonymous", nav).toggleClass("hidden")
  $(_homeSignupForm).hide()

showLoginModal = (withText) ->
  _textNode = $(_signinModal).find(_signinText)
  if withText
    _textNode.show()
  $(_signinModal).one("hide", () -> _textNode.hide()).modal('show')

$.requireLogin = requireLogin = (cb) ->
  checkLogin(cb, () -> showLoginModal(true))
$.checkLogin = checkLogin


# login form callback
class SigninForm
  constructor: (_signinModal, _siginForm, _opts) -> 
    @signinModal = $(_signinModal)
    @signinForm = $(_signinForm)
    @errorNode = $(_signinError, @signinForm)

    @defaultOptions =
      beforeSend: () =>
      success: (event, resp) =>
        if resp.success
          @signinModal.modal('hide')
          checkLogin(loginCallback, () -> true)
      error: (event, response) =>
        errorObj = $.parseJSON(response.responseText)
        @errorNode.show().find(".message").text(errorObj.error)

    @options = $.extend({}, @defaultOptions, _opts)
    @bindCallbacks()

  bindCallbacks: () =>
    @signinForm.
      on("ajax:beforeSend", @options["beforeSend"]).
      on("ajax:success", @options["success"]).
      on("ajax:error", @options["error"]).
      on("ajax:complete", @options["complete"])
    hide = () => @errorNode.hide()
    @signinModal.on("shown", hide)

# bind login link
$ ->
  $(_signinLink).click (event) ->
    $($(this).data("target")).modal "show"
  # check login
  checkLogin(loginCallback, () -> true)
  # bind signin form callbacks
  new SigninForm(_signinModal, _signinForm)

