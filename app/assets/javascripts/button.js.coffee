$=jQuery

class Button
  constructor: (_node) ->
    @node = $(_node)
    @node.on("mouseenter", @onMouseEnter).on("mouseleave", @onMouseLeave)

  onMouseEnter: () =>
    if (!@node.hasClass("disabled"))
      @node.addClass("hover")

  onMouseLeave: () =>
    if (!@node.hasClass("disabled"))
      @node.removeClass("hover")

$ ->
  $(".button").each((n) ->
    new Button(this))
