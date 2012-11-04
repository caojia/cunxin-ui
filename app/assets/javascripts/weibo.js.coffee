$ = jQuery

_shareButtons = ".weibo-share-btn"
_followButtons = ".weibo-follow-btn"
_globalButtonId = 0

class WeiboButton
  constructor: (@button, bindClick = false) ->
    _globalButtonId += 1
    @id = "weibo-btn-" + _globalButtonId
    $("<div />").addClass("hide").attr("id", @id).appendTo($("body"))
    @bindWB(@id)

    if (bindClick) 
      @button.click(@showWB)

  bindWB: (id) =>
  
  showWB: () =>
    $("#" + @id).click()

class WeiboShareButton extends WeiboButton
  bindWB: (id) =>
    WB2.anyWhere((W) ->
      W.widget.publish({
        'id': id
      })
    )

class WeiboFollowButton extends WeiboButton
  bindWB: (id) =>
    WB2.anyWhere((W) ->
      W.widget.followButton({
        'id': id,
        'nick_name': '寸心技术'
      })
    )

$ ->
  $(_shareButtons).each((i, node) ->
    new WeiboShareButton($(node), true))
  $(_followButtons).each((i, node) ->
    new WeiboFollowButton($(node), true))


