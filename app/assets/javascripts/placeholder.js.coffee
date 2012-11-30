$ = jQuery

_placeHolderSelector = "input.placeholder"
_placeHolderClass = "placeholder-show"

class PlaceHolder
  constructor: (@input, @placeHolderClass) ->
    @input.data("type", @input.attr("type"))

    @replaceInput = $("<input type='text'/>").
      addClass("placeholder-show").
      val(@input.data("placeholder")).
      hide()
    @replaceInput.insertAfter(@input)

    @blurInput()

    @input.blur(@blurInput)
    @replaceInput.focus(@focusPlaceHolder)


  showPlaceHolder: () =>
    @input.hide()
    @replaceInput.css("display", "inline-block")

  hidePlaceHolder: () =>
    @replaceInput.hide()
    @input.css("display", "inline-block")
    @input.focus()

  focusPlaceHolder: () =>
    @hidePlaceHolder()

  blurInput: () =>
    if @input.val() == ""
      @showPlaceHolder()

$ -> 
  $(_placeHolderSelector).each (i, n) ->
    new PlaceHolder($(this), _placeHolderClass)
