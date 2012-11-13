$ = jQuery
col3Carousel = ".col3-carousel"
col4Carousel = ".col4-carousel"

_itemSelector = ".item"
_interval = 10000

_headCarousel = "#head-carousel"
_headCarouselButton = "#head-carousel-control-button .carousel-control-button"

_headCarouselInner = "#head-carousel .carousel-inner"
_headCarouselWidth = 1280
_headCarouselHeight = 450
_verticalCentered = "#head-carousel .carousel-control, #head-carousel .home-signup-form-container"

_largeResizeableWidth = 1440
_resizeableSelector = "img.resizeable"

_homeInputBox = "#home-signup-form input"

class FadeCarousel
  constructor: (@element, @autostart, @interval) ->
    _items = @items = @element.find(_itemSelector)
    _length = @items.length
    if _length <= 1
      return
    @items.each (i, node) ->
      prev = (_length + i - 1) % _length
      $(_items[prev]).data("next-carousel", $(this))
      $(this).data("prev-carousel", $(_items[prev]))

    @current = $(@items[0])
    @next = $(@items[0]).data("next-carousel")

    @element.find(".right").click(@switchNext)
    @element.find(".left").click(@switchPrev)

    if @autostart
      @interval = @interval || _interval
      @start()

  pause: () =>
    if @intervalHandler
      clearInterval(@intervalHandler)

  start: () =>
    @intervalHandler = setInterval(@switchNext, @interval)

  hideCurrent: () =>
    @current.fadeOut () ->
      $(this).removeClass("active")

  showNext: () =>
    @next.fadeIn () ->
      $(this).addClass("active")

  switchCompleted: () =>
    @current = @next
    @element.trigger("fade-carousel-shown", {current: @current})

  switchNext: () =>
    @next = @current.data("next-carousel")
    $.when(@hideCurrent(), @showNext()).done(@switchCompleted)

  switchPrev: () =>
    @next = @current.data("prev-carousel")
    $.when(@hideCurrent(), @showNext()).done(@switchCompleted)

  showItem: (i) =>
    if ("number" == (typeof i))
      @next = $(@items[i])
      $.when(@hideCurrent, @showNext).done(@switchCompleted)
    else
      @next = $(i)
      $.when(@hideCurrent, @showNext).done(@switchCompleted)

class FixedRatio
  constructor: (@element, @width, @height, @verticalCenteredElement) ->
    $(window).resize(@resize)
    @resize()

  resize: () =>
    width = @element.width()
    height = width * @height / @width
    @element.height(height)

    @verticalCenteredElement.each (i, node) ->
      $(this).css("top", (height - $(this).height())/2)

class ResizeableImage
  constructor: (@element, @thd = _largeResizeableWidth) ->
    @smallSrc = @element.attr("src")
    @largeSrc = @element.data("image-large")
    if @largeSrc
      @current = "small"
      @resize()

  resize: () =>
    width = $(document).width()
    if (width >= @thd) 
      @switchToLarge()
    else
      @switchToSmall()

  switchToSmall: () =>
    if (@current != "small")
      @element.attr("src", @smallSrc)
      @current = "small"

  switchToLarge: () =>
    if (@current != "large")
      @element.attr("src", @largeSrc)
      @current = "large"

$ -> 
  $(col3Carousel).carousel "pause"
  $(col4Carousel).carousel "pause"

  _carousel = new FadeCarousel($(_headCarousel), true, _interval)
  $(_homeInputBox).on("keydown", () ->
    _carousel.pause()
    _carousel.start()
  )
  new FixedRatio($(_headCarouselInner), _headCarouselWidth, _headCarouselHeight, $(_verticalCentered))
  $(_resizeableSelector).each (i, node) -> new ResizeableImage($(this))
