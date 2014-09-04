namespace 'Site', (exports) ->
  class exports.Disqus
    
    constructor: (@identifier, @url)->
      @comments        = document.getElementById('disqus_thread')
      @disqusLoaded    = false
      @disqusShortname = "samthornton"
      @initDisqus()

    createEmbedScript: ->
      @dsq             = document.createElement('script')
      @dsq.type        = "text/javascript"
      @dsq.async       = true
      @dsq.src         = "//#{@disqusShortname}.disqus.com/embed.js"

    resetDisqus: ->
      self = @
      DISQUS.reset
        reload: true
        config: ->
          @page.identifier = self.identifier
          @page.url = self.url

    loadDisqus: ->
      if window.DISQUS
        @resetDisqus()
      else
        @createEmbedScript()
        (document.head or document.body).appendChild(@dsq)
      @disqusLoaded = true

    bookmarkLoad: ->
      if window.location.hash.indexOf('#comments') >= 0
        @loadDisqus()

    initDisqus: ->
      @bookmarkLoad()

      if @comments
        if !@disqusLoaded and window.pageYOffset > $('#disqus_thread').offset().top - 1500 then @loadDisqus()

        $(window).on 'scroll', =>
          if !@disqusLoaded and window.pageYOffset > $('#disqus_thread').offset().top - 1500
            @loadDisqus()
