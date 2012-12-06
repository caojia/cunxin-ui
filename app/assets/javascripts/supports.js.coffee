$ = jQuery

_contentContainer = ".support-page div.content"
_contentItems = ".pic-block"

$ ->
  $(_contentContainer).imagesLoaded(
    ()->
      $(_contentItems).fadeIn()
      $(_contentContainer).masonry( {
        width: 300,
        itemSelector: _contentItems })
  )

