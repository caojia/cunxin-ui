$=jQuery

class CountdownClock
  constructor: (@element, @target_time) ->

  updateText: ()->
    timeDiff = Math.max(@target_time - $.now(), 0)
    seconds = Math.floor(timeDiff / 1000) % 60
    minutes = Math.floor(timeDiff / (1000*60)) % 60
    hours = Math.floor(timeDiff / (1000*60*60)) % 24
    days = Math.floor(timeDiff / (1000*60*60*24))
    text = sprintf("%02d<span>天</span>%02d<span>时</span>%02d<span>分</span>%02d<span>秒</span>",
      days, hours, minutes, seconds)
    @element.html(text)

  start: () ->
    self = this
    @intervalHandler = setInterval( (() => @updateText()) , 1000)

  pause: () ->
    if @intervalHandler
      clearInterval(@intervalHandler)

root = exports ? window
root.CountdownClock = CountdownClock
