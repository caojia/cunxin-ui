$ = jQuery

_contentContainer = ".support-page div.content"
_contentItems = ".pic-block"
_contentWrapper = ".pic-block .pic-content-wrapper"
_contentItemLink = ".support-page .pic-block a.show-image-link"
_largeImageModal = "#large-image-modal"
_largeImage = "#large-image-modal img"
_largeImageSrc = "cunxin-thumb-large-src"

$ ->
  _body = $("body")
  $(_largeImageModal).on('hide',
    () ->
      _body.removeClass("noscroll")
  )
  $(_contentContainer).imagesLoaded(
    () ->
      $(_contentItems).fadeIn()
      $(_contentContainer).masonry( {
        width: 300,
        itemSelector: _contentItems })
  )
  $(_contentContainer).infinitescroll({
      navSelector: '#page-nav',
      nextSelector: '#page-nav a',
      itemSelector: '.pic-block',
      loading: {
        finishedMsg: 'No more pages'
      },
    },
    (newElements) ->
      newElems = $(newElements)
      newElems.imagesLoaded(
        () ->
          newElems.fadeIn()
          $(_contentContainer).masonry( 'appended', newElems, true)
      )
  )
  $(_contentContainer).on("click", _contentItemLink,
    (event) ->
      $(_largeImage)
        .hide()
      $(_largeImage)
        .attr({src: $(event.currentTarget).data("cunxin-thumb-large-src")})
        .show()
      _body.addClass("noscroll")
      $(_largeImageModal).modal("show")
      false
  )
  $(_contentWrapper).hover(
    (event) ->
      $(event.currentTarget).stop().animate({"margin-top": "-5px", "margin-left": "-5px", "padding": "15px"}, 250)
    ,
    (event) ->
      $(event.currentTarget).stop().css({"margin-top": "", "margin-left": "", "padding": ""}))
