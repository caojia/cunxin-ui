$ = jQuery

_thumbs = ".cunxin-thumb"
_target = ".cunxin-thumb-large-container"
_selectedClass = "cunxin-thumb-selected"
_placeHolderClass = "cunxin-thumb-large-place-holder"

_dataTargetName = "cunxin-thumb-target"
_dataThumbLarge = "cunxin-thumb-large"
_dataThumbLargeSrc = "cunxin-thumb-large-src"

class Thumbnail
  constructor: (thumbs) ->
    @thumbs = $(thumbs)
    if (@thumbs.data(_dataTargetName))
      @target = $(@thumbs.data(_dataTargetName))
    else
      @target = $(_target)

    @visibleImg = @target.find("img:visible")
    target = @target
    @thumbs.each((i, thumb) ->
      img = $("<img />").
        attr("src", $(thumb).data(_dataThumbLargeSrc)).
        addClass(_placeHolderClass).
        hide().
        appendTo(target)
      $(thumb).data(_dataThumbLarge, img))
    @thumbs.click(@onclick).first().addClass(_selectedClass)

  hideCurrent: () => @visibleImg.fadeOut()

  showLarge: () =>
    @currentTarget.data(_dataThumbLarge).fadeIn()

  switchSelected: () =>
    @visibleImg = @currentTarget.data(_dataThumbLarge)
    @thumbs.removeClass(_selectedClass)
    @currentTarget.addClass(_selectedClass)

  onclick: (event) =>
    @currentTarget = $(event.currentTarget)
    $.when(@hideCurrent(), @showLarge()).done(@switchSelected)
    event.preventDefault()

$ -> 
  new Thumbnail(_thumbs)

