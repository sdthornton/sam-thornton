// @Touch =
//   horizontalSensitivity: 22
//   verticalSensitivity: 6
//   touchDX: 0
//   touchDY: 0
//   touchStartX: 0
//   touchStartY: 0
//
//   bind: (elements...) ->
//     for elem in elements
//       elem.addEventListener "touchstart", (event) =>
//         @handleStart(event, elem)
//       elem.addEventListener "touchmove", (event) =>
//         @handleMove(event, elem)
//       elem.addEventListener "touchend", (event) =>
//         @handleEnd(event, elem)
//
//   handleStart: (event, elem) ->
//     if event.touches.length is 1
//       @touchDX = 0
//       @touchDY = 0
//       @touchStartX = event.touches[0].pageX
//       @touchStartY = event.touches[0].pageY
//
//   handleMove: (event, elem) ->
//     if event.touches.length > 1
//       @cancelTouch(elem)
//       return false
//
//     @touchDX = event.touches[0].pageX - @touchStartX
//     @touchDY = event.touches[0].pageY - @touchStartY
//
//   handleEnd: (event, elem) ->
//     dx = Math.abs(@touchDX)
//     dy = Math.abs(@touchDY)
//
//     if (dx > @horizontalSensitivity) and (dy < (dx * 2/3))
//       if @touchDX > 0 then @emitSlideRight() else @emitSlideLeft()
//
//     if (dy > @verticalSensitivity) and (dx < (dy * 2/3))
//       if @touchDY > 0 then @emitSlideDown() else @emitSlideUp()
//
//     @cancelTouch(event, elem)
//     return false
//
//   emitSlideLeft: -> $.event.trigger "swipe:left"
//   emitSlideRight: -> $.event.trigger "swipe:right"
//   emitSlideUp: -> $.event.trigger "swipe:up"
//   emitSlideDown: -> $.event.trigger "swipe:down"
