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
_headCarouselControl = "#head-carousel .carousel-control"

class FadeCarousel
  constructor: (@element, @autostart, @interval) ->
    _items = @items = @element.find(_itemSelector)
    @items.each (i, node) ->
      if (i > 0)
        $(_items[i-1]).data("next-carousel", $(this))
      $(this).data("prev-carousel", $(_items[i+1 % _items.length]))

    _length = @items.length
    $(@items[_length-1]).data("next-carousel", $(@items[0]))

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

    @verticalCenteredElement.css("top", (height - @verticalCenteredElement.height())/2)

$ -> 
  $(col3Carousel).carousel "pause"
  $(col4Carousel).carousel "pause"

  _carousel = new FadeCarousel($(_headCarousel), true, _interval)
  new FixedRatio($(_headCarouselInner), _headCarouselWidth, _headCarouselHeight, $(_headCarouselControl))
