$ = jQuery

_contentContainer = ".support-page div.content"
_contentItems = ".pic-block"
_contentWrapper = ".pic-block .pic-content-wrapper"
_contentItemLink = ".support-page .pic-block a"
_largeImageModal = "#large-image-modal"
_largeImage = "#large-image-modal img"
_largeImageSrc = "cunxin-thumb-large-src"

$ ->
  $(_contentContainer).imagesLoaded(
    () ->
      $(_contentItems).fadeIn()
      $(_contentContainer).masonry( {
        width: 300,
        itemSelector: _contentItems })
  )
  $(_contentItemLink).click(
    (event) ->
      $(_largeImage).attr({src: $(event.currentTarget).data("cunxin-thumb-large-src")})
      $(_largeImageModal).modal("show")
      false
  )
  $(_contentWrapper).hover(
    (event) ->
      $(event.currentTarget).stop().animate({"margin-top": "-5px", "margin-left": "-5px", "padding": "15px"}, 250)
    ,
    (event) ->
      $(event.currentTarget).stop().css({"margin-top": "", "margin-left": "", "padding": ""}))
