$ = jQuery

_navbar = "#cunxin-nav"
_mask = ".mask"
_hiddenOpacityClass = "opacity0"
_showOpacityClass = "opacity3"
_masthead = ".nav-scroll-control"

class NavBar
  constructor: (@navbar, @masthead) -> @mask = @navbar.find(_mask)

  showBG: () -> @mask.removeClass(_hiddenOpacityClass).addClass(_showOpacityClass)

  hideBG: () -> @mask.removeClass(_showOpacityClass).addClass(_hiddenOpacityClass)

  update: () =>
    _scrollHeight = $(window).scrollTop()
    _height = (@masthead.height() || 0) - @navbar.height()
    if _height >= _scrollHeight
      this.hideBG()
    else
      this.showBG()

  bindEvents: () =>
    $(window).on("scroll", this.update).on("resize", this.update)
    return this

$ -> 
  (new NavBar($(_navbar), $(_masthead))).bindEvents().update()
