$ = jQuery

_thumbs = ".cunxin-thumb"
_target = ".cunxin-thumb-large-container"
_headWrapper = ".head-carousel-wrapper"
_thumbIndicator = ".cunxin-thumb-indicator"
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
    @currentTarget = @thumbs.first()
    @updateThumbIndicatorPos()

  hideCurrent: () => @visibleImg.fadeOut()

  showLarge: () =>
    @currentTarget.data(_dataThumbLarge).fadeIn()

  switchSelected: () =>
    @visibleImg = @currentTarget.data(_dataThumbLarge)
    @thumbs.removeClass(_selectedClass)
    @currentTarget.addClass(_selectedClass)

  onclick: (event) =>
    @currentTarget = $(event.currentTarget)
    @updateThumbIndicatorPos()
    $.when(@hideCurrent(), @showLarge()).done(@switchSelected)
    event.preventDefault()

  updateThumbIndicatorPos: () =>
    if @currentTarget.get(0)
      indicator = $(_thumbIndicator)
      indicator.animate(
        {left: (@currentTarget.offset().left-$(_headWrapper).offset().left)+@currentTarget.outerWidth()/2-indicator.outerWidth()/2}
        , 500
      )

$ ->
  new Thumbnail(_thumbs)

