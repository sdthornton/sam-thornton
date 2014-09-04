# namespace 'Site', (exports) ->
#   class exports.PageTransition
#
#     constructor: ->
#       @showSection()
#       @bindPageChanges()
#
#     getMainSections: =>
#       @mainSections = document.querySelectorAll('.main-section')
#
#     showSection: =>
#       @getMainSections()
#       for mainSection in @mainSections
#         mainSection.classList.add('visible-section')
#
#     hideSection: =>
#       @getMainSections()
#       for mainSection in @mainSections
#         mainSection.classList.remove('visible-section')
#
#     bindPageChanges: ->
#       $(document).on('page:fetch', @hideSection)
#       .on('page:change', @showSection)
#
# new Site.PageTransition()
