$ = jQuery

_navbar = "#cunxin-nav"
_mask = ".mask"
_hiddenOpacityClass = "opacity1"
_showOpacityClass = "opacity8"
_masthead = "#head-carousel"

class NavBar
  constructor: (@navbar, @masthead) -> @mask = @navbar.find(_mask)

  showBG: () -> @mask.removeClass(_hiddenOpacityClass).addClass(_showOpacityClass)

  hideBG: () -> @mask.removeClass(_showOpacityClass).addClass(_hiddenOpacityClass)

  update: () =>
    _scrollHeight = $(window).scrollTop()
    _height = @masthead.height() - @navbar.height()
    console.log(@masthead.height(), @navbar.height(), _height)
    if _height >= _scrollHeight
      this.hideBG()
    else
      this.showBG()

  bindEvents: () =>
    $(window).on("scroll", this.update).on("resize", this.update)

$ -> 
  (new NavBar($(_navbar), $(_masthead))).bindEvents()