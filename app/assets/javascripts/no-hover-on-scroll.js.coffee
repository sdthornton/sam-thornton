namespace 'Site', (exports) ->
  class exports.NoHoverOnScroll

    constructor: ->
      @enableTimer = 0
      @bindScrolling()

    bindScrolling: ->
      window.addEventListener 'scroll', @toggleHoverClass, false

    toggleHoverClass: =>
      clearTimeout(@enableTimer)
      @removeHoverClass()
      @enableTimer = setTimeout(@addHoverClass, 250)

    removeHoverClass: =>
      document.documentElement.classList.remove('hover')

    addHoverClass: =>
      document.documentElement.classList.add('hover')
