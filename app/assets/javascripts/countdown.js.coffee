$=jQuery

class CountdownClock
  constructor: (@element, @target_time) ->
    console.log(@element)
    console.log(@target_time)

  updateText: ()->
    timeDiff = Math.max(@target_time - $.now(), 0)
    seconds = Math.floor(timeDiff / 1000) % 60
    minutes = Math.floor(timeDiff / (1000*60)) % 60
    hours = Math.floor(timeDiff / (1000*60*60)) % 24
    days = Math.floor(timeDiff / (1000*60*60*24))
    text = days + "天" + hours + "小时" + minutes + "分" + seconds + "秒"
    @element.text(text)

  start: () ->
    self = this
    @intervalHandler = setInterval( (() => @updateText()) , 1000)

  pause: () ->
    if @intervalHandler
      clearInterval(@intervalHandler)

root = exports ? window
root.CountdownClock = CountdownClock
