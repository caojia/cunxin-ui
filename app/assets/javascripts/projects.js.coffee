$ = jQuery

_followLink = "#project-follow"
_followCountDiv = "#followed-count-container div.desc-detail.amount-text"
_followingButton = "#project-following"
_checkFollowingUrlAttr = "check-following-url"

_currentNode = null

_callbacks =
  "beforeSend": () ->
    _currentNode = $(this)
    if _currentNode.hasClass("loading")
      return false
    else
      _loggedIn = false
      $.requireLogin(() ->
        _loggedIn = true
        _currentNode.addClass("loading"))
      return _loggedIn

  "success": (event, resp) ->
    showInfo(resp.info)
    $(_followCountDiv).text(resp.total_followed)

  "error": (event, resp) ->
    try
      error = $.parseJSON(resp.responseText).error
      showError(error)
    catch error
      ""

  "complete": () ->
    _currentNode.removeClass("loading")

showInfo = (info) -> _setFollowingState(true)
showError = (error) -> alert(error)

_setFollowingState = (isFollowing) ->
  if isFollowing
    $(_followLink).parents(".button").hide().addClass("hidden")
    $(_followingButton).show().removeClass("hidden")
  else
    $(_followingButton).hide().addClass("hidden")
    $(_followLink).parents(".button").show().removeClass("hidden")

_checkFollowing = () ->
  url = $(_followLink).data(_checkFollowingUrlAttr)
  if url
    $.getJSON(url, (data) ->
      if data.is_following
        _setFollowingState(true)
    )

$ ->
  $(_followLink).
    on("ajax:beforeSend", _callbacks.beforeSend).
    on("ajax:success", _callbacks.success).
    on("ajax:error", _callbacks.error).
    on("ajax:complete", _callbacks.complete)
  $.checkLogin(_checkFollowing)
  if "undefined" != (typeof targetDate)
    $('#countdown-timer').countdown({
      timestamp: targetDate,
      DaysText: '天',
      HoursText: '时',
      MinutesText: '分',
      SecondsText: '秒'
    })
