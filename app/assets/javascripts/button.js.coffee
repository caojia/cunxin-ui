$=jQuery

class Button
  constructor: (_node) ->
    @node = $(_node)
    @node.on("mouseenter", @onMouseEnter).on("mouseleave", @onMouseLeave)

  onMouseEnter: () =>
    @node.addClass("hover")

  onMouseLeave: () =>
    @node.removeClass("hover")

$ ->
  $(".button").each((n) ->
    new Button(this))
