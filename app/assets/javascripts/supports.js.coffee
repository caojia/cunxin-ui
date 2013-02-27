$ = jQuery

_contentContainer = ".support-page div.content"
_contentItems = ".pic-block"
_contentWrapper = ".pic-block .pic-content-wrapper"
_contentItemLink = ".support-page .pic-block a.show-image-link"
_largeImageModal = "#large-image-modal"
_largeImage = "#large-image-modal img.large-image"
_largeImageSrc = "cunxin-thumb-large-src"
_loadingIndicator = ".support-page div.content img.loading"
_largeImageWrapper = "#large-image-modal .large-image-wrapper"
_modalLoadingIndicator = "#large-image-modal img.loading"

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
          $(_loadingIndicator).hide()
          newElems.fadeIn()
          $(_contentContainer).masonry( 'appended', newElems, true)
      )
  )
  $(_contentContainer).on("click", _contentItemLink,
    (event) ->
      $(_largeImage).remove()
      winH = $(window).height()
      $(_modalLoadingIndicator).css({"margin-top": Math.max(winH*0.4, 100)-24 + "px"}).show()
      img =
        $("<img class='large-image'/>")
          .attr({src: $(event.currentTarget).data("cunxin-thumb-large-src")})
          .load(
            () ->
              $(_modalLoadingIndicator).hide()
              $(_largeImageWrapper).append(img)
          )
      _body.addClass("noscroll")
      $(_largeImageModal).css({height: Math.max(winH*0.8, 200) + "px", "margin-top": (-winH*0.4-25)+"px"}).modal("show")
      false
  )
  $(_contentWrapper).hover(
    (event) ->
      $(event.currentTarget).stop().animate({"margin-top": "-5px", "margin-left": "-5px", "padding": "15px"}, 250)
    ,
    (event) ->
      $(event.currentTarget).stop().css({"margin-top": "", "margin-left": "", "padding": ""}))
