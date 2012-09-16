$ = jQuery

_signinLink = ".signin-modal-link"

_cookieMap =
  id: "_cunxin_id"
  name: "_cunxin_name"
  thumb: "_cunxin_thumb"

checkLogin = (login_cb, logout_cb) ->
  id = $.cookie(_cookieMap.id)
  if id > 0
    login_cb && login_cb(id, $.cookie(_cookieMap.name), $.cookie(_cookieMap.thumb))
  else
    login_cb && logout_cb()

loginCallback = (id, name, thumb) ->
  nav = $("#login-nav")
  if thumb
    $(".loggedin.user-thumb img", nav).attr("src", thumb).toggleClass("hidden")
  if name
    $(".loggedin.user-name a", nav).html(escape(name))

  $(".loggedin, .anonymous", nav).toggleClass("hidden")

# bind login link
$ ->
  $(_signinLink).click (event) ->
    $($(this).data("target")).modal "show"

# check login
$ -> 
  checkLogin(loginCallback, () -> true)
