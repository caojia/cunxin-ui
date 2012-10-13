$ = jQuery

_followLink = "#project-follow"
_followCountSpan = "#followed-count-container .num"

_currentNode = null

_callbacks = 
  "beforeSend": () ->
    _currentNode = $(this)
    if _currentNode.hasClass("loading")
      return false
    else
      _currentNode.addClass("loading")

  "success": (event, resp) ->
    showInfo(resp.info)
    $(_followCountSpan).text(resp.total_followed)

  "complete": () ->
    _currentNode.removeClass("loading")

showInfo = (info) -> alert(info)

$ ->
  $(_followLink).
    on("ajax:beforeSend", _callbacks.beforeSend).
    on("ajax:success", _callbacks.success).
    on("ajax:complete", _callbacks.complete)
