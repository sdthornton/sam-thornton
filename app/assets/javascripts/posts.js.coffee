# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

namespace 'Site', (exports) ->
  class exports.PostEdit

    constructor: (@el) ->
      @createContentEditor()
      @bindUpdateInput()
      @createEditElements()
      @bindEditElements()
      @watchSelection()

    createContentEditor: ->
      @editor =
        $('<div />', {
          class: @el.attr('class') + " editable"
          id: @el.attr('id') + "_editable"
          contenteditable: true
        })
      @editor.insertAfter(@el)
      @el.hide()

    updateInput: ->
      @el.val(@editor.html())

    bindUpdateInput: ->
      @editor.on 'keyup.updateInput blur.updateInput paste.updateInput', (e) =>
        @updateInput()

    surroundSelection: (wrapEl) ->
      wrapEl = document.createElement(wrapEl)
      if window.getSelection
        selection = window.getSelection()
        if selection.rangeCount
          selectionRange = selection.getRangeAt(0).cloneRange()
          selectionRange.surroundContents(wrapEl)
          selection.removeAllRanges()
          selection.addRange(selectionRange)

          if selectionRange.toString().length == 0
            wrapEl.innerHTML = "&#8203"
            newRange = document.createRange()
            newRange.selectNodeContents(wrapEl)
            newRange.collapse(false)
            selection.removeAllRanges()
            selection.addRange(newRange)

    setState: (state) ->
      document.execCommand(state, false, null)

    createEditElements: ->
      @editElementsWrap =
        $('<div />', {
          class: "edit_elements_wrapper"
          id: "edit_elements_wrapper"
        })
      @editElementsWrap.insertBefore(@editor)

      @makeBold = "<button id='make_bold' class='make_bold edit_button simple_state' rel='bold'>B</button>"
      @makeItalic = "<button id='make_italic' class='make_italic edit_button simple_state' rel='italic'>i</button>"

      @editElementsWrap.html(@makeBold + @makeItalic)

    bindEditElements: ->
      $('button.simple_state').on 'click.changeState', (e) =>
        e.preventDefault()
        e.stopPropagation()
        state = $(e.target).attr('rel')
        @setState(state)
        @updateInput()

    watchSelection: ->
      @editor.on 'mouseup.watchSelection keydown.watchSelection', (e) =>
        $('button.edit_button').removeClass('active')

        # node = e.target
        # while node.nodeName != 'DIV'
        #   $('button[rel='+node.nodeName+']').addClass('active')
        #   node = node.parentNode
