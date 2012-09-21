# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery
_headCarousel = "#head-carousel"
_headCarouselButton = "#head-carousel-control-button .carousel-control-button"
interval = 4000

$ ->
  _carousel = $(_headCarousel).
    carousel(interval: interval).
    on("slid", () -> 
      i = $(this).find(".active").index(".item") + 1
      $(_headCarouselButton + ".active").toggleClass("active")
      $(_headCarouselButton + ":nth-child("+i+")").toggleClass("active"))

  $(_headCarouselButton).click( ->
    i = $(this).data("carousel-index")
    _carousel.carousel(i)
    return false)

