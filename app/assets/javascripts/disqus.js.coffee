namespace 'Site', (exports) ->
  class exports.Disqus

    constructor: ->
      @comments        = document.getElementById('disqus_thread')
      @disqusLoaded    = false
      @disqusShortname = "samthornton"
      @dsq             = document.createElement('script')
      @dsq.type        = "text/javascript"
      @dsq.async       = true
      @dsq.src         = "//#{@disqusShortname}.disqus.com/embed.js"

      @init()

    loadDisqus: ->
      (document.getElementsByTagName('head')[0] or document.getElementsByTagName('body')[0]).appendChild(@dsq)
      @disqusLoaded = true

    bookmarkLoad: ->
      if window.location.hash.indexOf('#comments') >= 0
        @loadDisqus()

    init: ->
      @bookmarkLoad()

      if @comments
        if !@disqusLoaded and window.pageYOffset > $('#disqus_thread').offset().top - 1500 then @loadDisqus()

        $(window).on 'scroll', =>
          if !@disqusLoaded and window.pageYOffset > $('#disqus_thread').offset().top - 1500
            @loadDisqus()
