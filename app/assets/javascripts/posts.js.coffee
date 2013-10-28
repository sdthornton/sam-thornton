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

    setState: (state, info) ->
      document.execCommand(state, false, info)

    getState: (state) ->
      document.queryCommandState(state)

    createEditElements: ->
      @editElementsWrap =
        $('<div />', {
          class: "edit_elements_wrapper"
          id: "edit_elements_wrapper"
        })
      @editElementsWrap.insertBefore(@editor)

      @editElements =
        bold: "<button id='make_bold' class='make_bold edit_button state_change' rel='bold'>B</button>"
        italic: "<button id='make_italic' class='make_italic edit_button state_change' rel='italic'>i</button>"
        strikeThrough: "<button id='make_strike' class='make_strike edit_button state_change' rel='strikeThrough'>S&#822</button>"
        underline: "<button id='make_underline' class='make_underline edit_button state_change' rel='underline'>U&#818</button>"
        orderedList: "<button id='make_ordered_list' class='make_ordered_list edit_button state_change' rel='insertorderedlist'>OL</button>"
        unorderedList: "<button id='make_unordered_list' class='make_unordered_list edit_button state_change' rel='insertunorderedlist'>UL</button>"
        justifyLeft: "<button id='make_justify_left' class='make_justify_left edit_button state_change' rel='justifyleft'>Left</button>"
        justifyRight: "<button id='make_justify_right' class='make_justify_right edit_button state_change' rel='justifyright'>Right</button>"
        justifyCenter: "<button id='make_justify_center' class='make_justify_center edit_button state_change' rel='justifycenter'>Center</button>"
        justifyFull: "<button id='make_justify_full' class='make_justify_full edit_button state_change' rel='justifyfull'>Full</button>"
        subscript: "<button id='make_subscript' class='make_subscript edit_button state_change' rel='subscript'>Sub</button>"
        superscript: "<button id='make_superscript' class='make_superscript edit_button state_change' rel='superscript'>Super</button>"
        createLink: "<button id='make_link' class='make_link edit_button state_change has_prompt' rel='createlink' data-promptinfo='{ \"title\": \"Write the URL here\", \"text\": \"http://\" }''>Link</button>"
        removeLink: "<button id='make_unlink' class='make_unlink edit_button state_change' rel='unlink'>Unlink</button>"
        quote: "<button id='make_quote' class='make_quote edit_button state_change format_block' rel='formatblock' data-blockformat='BLOCKQUOTE'>Quote</button>"
        heading: """
          <select id='make_heading' class='make_heading edit_dropdown state_change format_block' rel='formatblock'>
            <option value='h1'>Heading 1</option>
            <option value='h2'>Heading 2</option>
          </select>"""

      $.each @editElements, (i, val) =>
        @editElementsWrap.append(val)

    bindEditElements: ->
      $('button.edit_button').on 'click.changeState', (e) =>
        e.preventDefault()
        e.stopPropagation()
        state = $(e.target).attr('rel')

        if $(e.target).hasClass('has_prompt')
          promptInfo  = $(e.target).data('promptinfo')
          promptTitle = promptInfo.title
          promptText  = promptInfo.text
          @prompt     = prompt(promptTitle, promptText)
          if @prompt != '' && @prompt != 'http://'
            @setState(state, @prompt)
        else if $(e.target).hasClass('format_block')
          blockformat = $(e.target).data('blockformat')
          @setState(state, blockformat)
        else
          @setState(state)

        @toggleEditElements()
        @updateInput()
        @editor.focus()

      $('select.edit_dropdown').on 'change.changeState', (e) =>
        e.stopPropagation()
        state       = $(e.target).attr('rel')
        blockformat = $(e.target).val()
        console.log(blockformat)
        @setState(state, blockformat)

    toggleEditElements: ->
      $('button.edit_button').removeClass('active')
      @editElementsWrap.children().not('.format_block').each (i, el) =>
        $(el).removeClass('active')
        elState = $(el).attr('rel')
        state   = document.queryCommandState(elState)
        if state then $(el).addClass('active')

      node = window.getSelection().anchorNode.parentNode
      while node.nodeName != 'DIV' && node.id != 'edit_elements_wrapper'
        $('button.format_block[data-blockformat='+node.nodeName+']').addClass('active')
        node = node.parentNode

    watchSelection: ->
      @editor.on 'click.watchSelection keyup.watchSelection', (e) =>
        @toggleEditElements()
