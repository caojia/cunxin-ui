$ = jQuery

_unfollowLink = "#profile .unfollow-project"
_followedProjectContainer = "tr"
_followedProjects = "#profile .followed-projects .project"

_confirmationLink = "#profile #resend-confirmation"
_confirmationSent = "#profile #confirmation-resent"

reload = () -> document.location.reload()

$ ->
  $(_unfollowLink).
    on "ajax:success", 
      (event, resp) ->
        $(this).closest(_followedProjectContainer).remove()
        if $(_followedProjects).length <= 0
          reload()

  _sendingConfirmation = false
  $(_confirmationLink).
    on("ajax:beforeSend", () -> 
      if !_sendingConfirmation
        _sendingConfirmation = true
        return true
      return false).
    on("ajax:success",
      () -> 
        $.when($(_confirmationLink).parent().hide(), $(_confirmationSent).show()))

