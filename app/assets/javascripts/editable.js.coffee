$ = jQuery

_editableSelector = ".editable"


##
# = Editable
# <form class="editable" data-prefix="">
#   <div class="editable-icon-container">
#     <a class="editable-icon" />
#   </div>
#   <div class="field-content">xxxxx</div>
#   <input type="text" value="xxx" class="editing" />
#   <input type="submit" class="editing" />
#   <button class="editable-cancel editing" />
# </form>
#
# TODO: 
# 1. should add JS validation
# 2. show loading before submit
#

class Editable
  constructor: (_node) ->
    @node = $(_node)
    @form = @node.find("form:first").andSelf()
    @prefix = @form.data("prefix")

    @node.find(".editable-icon").
      on("click", () => @startEdit() && false)
    @node.find(".editable-cancel").
      on("click", () => @stopEdit() && false)

    @form.
      on("ajax:beforeSend", @beforeSubmit).
      on("ajax:success", @submitSuccess).
      on("ajax:error", @submitError)

  startEdit: () =>
    @node.
      removeClass("editable").
      addClass("editable-in-editing").
      find("input[type=password]").
        val("")
    @node.find("input:not([type=hidden]):first").focus()

  stopEdit: () =>
    @form.find(".warning").toggleClass("warning")
    @form.find(".help-inline").empty()
    @node.
      removeClass("editable-in-editing").
      addClass("editable")

  fieldId: (field) =>
    "#" + @prefix + "-" + field + "-field"

  beforeSubmit: () =>

  submitSuccess: (event, resp) =>
    for field, value of resp
      $(@fieldId(field) + " .field-content").text(value)
    @stopEdit()

  submitError: (event, resp) =>
    errors = $.parseJSON(resp.responseText)
    for field, value of errors
      $(@fieldId(field)).
        addClass("warning").
        find(".help-inline").
          text(value[0])

$ ->
  $(".editable").each((n) ->
    new Editable(this))
