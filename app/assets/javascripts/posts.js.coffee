# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

namespace 'Site', (exports) ->
  class exports.PostEdit

    constructor: (el) ->
      @el  = document.querySelector(el)
      @$el = $(@el)
      @createContentEditor()
      @bindUpdateInput()
      @createEditElements()
      @bindEditElements()
      @watchSelection()
      @createSnippet()

    createContentEditor: ->
      @$editor =
        $('<div />', {
          class: @$el.attr('class') + " editable"
          id: @$el.attr('id') + "_editable"
          contenteditable: true
        })
      @$editor.insertAfter(@$el)
      @el.style.display = 'none'

    updateInput: ->
      @$el.val(@$editor.html())

    bindUpdateInput: ->
      @$editor.on 'keyup.updateInput blur.updateInput paste.updateInput', (e) =>
        @updateInput()

    surroundSelection: (wrapEl, options) ->
      options      = options || {}
      wrapEl       = document.createElement(wrapEl)
      wrapEl.id    = options.id || ""
      wrapEl.class = options.class || ""

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
      @$editElementsWrap =
        $('<div />', {
          class: "edit-elements-wrapper"
          id: "edit-elements-wrapper"
        })
      @$editElementsWrap.insertBefore(@$editor)

      @editElements =
        bold: "<button id='make-bold' class='make-bold edit-button state-change' rel='bold'>B</button>"
        italic: "<button id='make-italic' class='make-italic edit-button state-change' rel='italic'>i</button>"
        strikeThrough: "<button id='make-strike' class='make-strike edit-button state-change' rel='strikeThrough'>S&#822</button>"
        underline: "<button id='make-underline' class='make-underline edit-button state-change' rel='underline'>U&#818</button>"
        orderedList: "<button id='make-ordered-list' class='make-ordered-list edit-button state-change' rel='insertorderedlist'>OL</button>"
        unorderedList: "<button id='make-unordered-list' class='make-unordered-list edit-button state-change' rel='insertunorderedlist'>UL</button>"
        justifyLeft: "<button id='make-justify-left' class='make-justify-left edit-button state-change' rel='justifyleft'>Left</button>"
        justifyRight: "<button id='make-justify-right' class='make-justify-right edit-button state-change' rel='justifyright'>Right</button>"
        justifyCenter: "<button id='make-justify-center' class='make-justify-center edit-button state-change' rel='justifycenter'>Center</button>"
        justifyFull: "<button id='make-justify-full' class='make-justify-full edit-button state-change' rel='justifyfull'>Full</button>"
        subscript: "<button id='make-subscript' class='make-subscript edit-button state-change' rel='subscript'>Sub</button>"
        superscript: "<button id='make-superscript' class='make-superscript edit-button state-change' rel='superscript'>Super</button>"
        createLink: "<button id='make-link' class='make-link edit-button state-change has-prompt' rel='createlink' data-promptinfo='{ \"title\": \"Write the URL here\", \"text\": \"http://\" }''>Link</button>"
        removeLink: "<button id='make-unlink' class='make-unlink edit-button state-change' rel='unlink'>Unlink</button>"

        quote: "<button id='make-quote' class='make-quote edit-button state-change format-block' rel='formatblock' data-blockformat='BLOCKQUOTE'>Quote</button>"
        heading: """
          <select id='make-heading' class='make-heading edit-dropdown state-change format-block' rel='formatblock'>
            <option value='' default selected disabled>Choose Format</option>
            <option value='h1'>Heading 1</option>
            <option value='h2'>Heading 2</option>
          </select>"""
        removeFormat: "<button id='make-noformat' class='make-noformat edit-button state-change' rel='removeFormat'>Remove Format</button>"
        makeIntro: "<button id='make-intro' class='make-intro edit-button'>Intro</button>"

      $.each @editElements, (i, val) =>
        @$editElementsWrap.append(val)

    bindEditElements: ->
      $('button.edit-button').on 'click.changeState', (e) =>
        e.preventDefault()
        e.stopPropagation()
        state = $(e.target).attr('rel')

        if $(e.target).hasClass('has-prompt')
          promptInfo  = $(e.target).data('promptinfo')
          promptTitle = promptInfo.title
          promptText  = promptInfo.text
          @prompt     = prompt(promptTitle, promptText)
          if @prompt != '' && @prompt != 'http://'
            @setState(state, @prompt)
        else if $(e.target).hasClass('format-block')
          blockformat = $(e.target).data('blockformat')
          @setState(state, blockformat)
        else if $(e.target).hasClass('make-noformat')
          @setState(state)
          @setState('formatBlock', 'p')
        else if $(e.target).hasClass('make-intro')
          @surroundSelection('span', { id: "post__intro" })
        else
          @setState(state)

        @toggleEditElements()
        @$editor.find('*').each (i, el) =>
          $(el)[0].classList.add("post__#{el.nodeName.toLowerCase()}")
        @updateInput()
        @$editor.focus()

      $('select.edit-dropdown').on 'change.changeState', (e) =>
        e.stopPropagation()
        state       = $(e.target).attr('rel')
        blockformat = $(e.target).val()
        @setState(state, blockformat)

      @$editor.on 'keypress.formatParagraph', (e) =>
        if e.target.innerHTML.replace(/\s/gi, '') == ''
          @setState('formatBlock', 'p')
          @$editor.find('p').addClass('post__p')
      .on 'keyup.formatParagraph', (e) =>
        if e.keyCode == 13 && !e.shiftKey
          @setState('formatBlock', 'p')
          @$editor.find('p').addClass('post__p')

    toggleEditElements: ->
      $('button.edit-button').removeClass('active')
      @$editElementsWrap.children().not('.format-block').each (i, el) =>
        $(el).removeClass('active')
        elState = $(el).attr('rel')
        state   = @getState(elState)
        if state then $(el).addClass('active')

      node = window.getSelection().anchorNode.parentNode
      while node.nodeName != 'DIV' && node.id != 'edit-elements-wrapper'
        $('button.format-block[data-blockformat='+node.nodeName+']').addClass('active')
        node = node.parentNode

    watchSelection: ->
      @$editor.on 'click.watchSelection keyup.watchSelection', (e) =>
        @toggleEditElements()

    createSnippet: ->
      @$editor.on 'blur.createSnippet', (e) =>
        document.getElementById('post_snippet').value = @$editor.find('#post__intro').html() || ""

