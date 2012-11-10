$ = jQuery

_answerSelector = ".answer"
_questionSelector = ".question"

$ ->
  $(_answerSelector).
    on("hide", () ->
      $(this).parent().children(_questionSelector).removeClass("question-open")
    ).
    on("show", () ->
      $(this).parent().children(_questionSelector).addClass("question-open")
    )
