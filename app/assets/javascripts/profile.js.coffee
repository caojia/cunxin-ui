$ = jQuery

_unfollowLink = "#profile .unfollow-project"
_followedProjectContainer = "tr"
_followedProjects = "#profile .followed-projects .project"

reload = () -> document.location.reload()

$ ->
  $(_unfollowLink).
    on "ajax:success", 
      (event, resp) ->
        $(this).closest(_followedProjectContainer).remove()
        if $(_followedProjects).length <= 0
          reload()

