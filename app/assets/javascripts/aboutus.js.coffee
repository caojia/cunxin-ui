$ = jQuery

_aboutWrapper = "#head-about-carousel"

_next = "#about-carousel-navs .next"
_prev = "#about-carousel-navs .prev"

_interval = 1000

_points = 
  "about-item-1": 
    "width": 800
    "height": 242
    "left": 0
    "top": 2
  "about-item-2":
    "width": 800
    "height": 199
    "left": 0
    "top": 4
  "about-item-3":
    "width": 800
    "height": 368
    "left": 2
    "top": 6
  "about-item-4":
    "width": 800
    "height": 368
    "left": 4
    "top": 4
  "about-item-5":
    "width": 800
    "height": 384
    "left": 4
    "top": 2
  "about-item-6":
    "width": 800
    "height": 400
    "left": 2
    "top": 3

class AboutPagePath
  constructor: (node, points, next, prev, interval = _interval) ->
    if node.length == 0
      return this
    ids = _.keys(points).sort()
    maxWidth = _.max(points, (point) -> point.width).width
    maxHeight = _.max(points, (point) -> point.height).height

    positions = {}

    for id, point of points
      point.left = point.left * maxWidth
      point.top = point.top * maxHeight
      $("#" + id).
        css("left", point.left + (maxWidth - point.width)/2).
        css("top", point.top + (maxHeight - point.height)/2).
        css("width", point.width).
        css("height", point.height)

      positions[id] = 
        x: point.left + maxWidth/2
        y: point.top + maxHeight/2

    node.show()

    path = $.fn.scrollPath("getPath")

    for id, i in ids
      if i == 0
        path = path.moveTo(positions[id].x, positions[id].y, {name: id})
      else
        path = path.lineTo(positions[id].x, positions[id].y, {name: id})

    id = ids[0]
    path.lineTo(positions[id].x, positions[id].y, {name: "end"})

    node.scrollPath({drawPath: false, wrapAround: true, scrollBar: false})
    $.fn.scrollPath("scrollTo", ids[0])

    @ids = ids
    @current = 0

    next.click(@next)
    prev.click(@prev)

  next: () =>
    @current = (@current + 1) % @ids.length
    $.fn.scrollPath("scrollTo", @ids[@current], _interval, "easeInOutSine")

  prev: () =>
    @current = (@current - 1 + @ids.length) % @ids.length
    $.fn.scrollPath("scrollTo", @ids[@current], _interval, "easeInOutSine")


$ -> 
  new AboutPagePath($(_aboutWrapper), _points, $(_next), $(_prev))

