// namespace 'Site', (exports) ->
//   class exports.PostEdit
//
//     constructor: (el) ->
//       @el = document.querySelector(el)
//       @$el = $(@el)
//       @createContentEditor()
//       @bindUpdateInput()
//       @createEditElements()
//       @bindEditElements()
//       @watchSelection()
//       @createSnippet()
//
//     createContentEditor: ->
//       @$editor =
//         $ '<div />',
//           class: @$el.attr('class') + " editable"
//           id: @$el.attr('id') + "_editable"
//           contenteditable: true
//       @$editor.insertAfter(@$el)
//       @el.style.display = 'none'
//
//     updateInput: =>
//       @$el.val(@$editor.html())
//
//     bindUpdateInput: ->
//       @$editor.on 'keyup.updateInput blur.updateInput paste.updateInput', @updateInput
//
//     surroundSelection: (wrapEl, options) ->
//       options = options || {}
//       wrapEl = document.createElement(wrapEl)
//       wrapEl.id = options.id || ""
//       wrapEl.class = options.class || ""
//
//       if window.getSelection
//         selection = window.getSelection()
//         if selection.rangeCount
//           selectionRange = selection.getRangeAt(0).cloneRange()
//           selectionRange.surroundContents(wrapEl)
//           selection.removeAllRanges()
//           selection.addRange(selectionRange)
//
//           if selectionRange.toString().length == 0
//             wrapEl.innerHTML = "&#8203"
//             newRange = document.createRange()
//             newRange.selectNodeContents(wrapEl)
//             newRange.collapse(false)
//             selection.removeAllRanges()
//             selection.addRange(newRange)
//
//     setState: (state, info) ->
//       document.execCommand(state, false, info)
//
//     getState: (state) ->
//       document.queryCommandState(state)
//
//     createEditElements: ->
//       @$editElementsWrap =
//         $('<div />', {
//           class: "edit-elements-wrap"
//           id: "edit_elements_wrap"
//         })
//       @$editElementsWrap.insertBefore(@$editor)
//
//       @editElements =
//         bold: "<button id='make_bold' class='make-bold edit-button state-change' rel='bold'></button>"
//         italic: "<button id='make_italic' class='make-italic edit-button state-change' rel='italic'></button>"
//         strikeThrough: "<button id='make_strike' class='make-strike edit-button state-change' rel='strikeThrough'></button>"
//         underline: "<button id='make_underline' class='make-underline edit-button state-change' rel='underline'></button>"
//         orderedList: "<button id='make_ordered_list' class='make-ordered-list edit-button state-change' rel='insertorderedlist'></button>"
//         unorderedList: "<button id='make_unordered_list' class='make-unordered-list edit-button state-change' rel='insertunorderedlist'></button>"
//         justifyLeft: "<button id='make_justify_left' class='make-justify-left edit-button state-change' rel='justifyleft'></button>"
//         justifyRight: "<button id='make_justify_right' class='make-justify-right edit-button state-change' rel='justifyright'></button>"
//         justifyCenter: "<button id='make_justify_center' class='make-justify-center edit-button state-change' rel='justifycenter'></button>"
//         justifyFull: "<button id='make_justify_full' class='make-justify-full edit-button state-change' rel='justifyfull'></button>"
//         createLink: "<button id='make_link' class='make-link edit-button state-change has-prompt' rel='createlink' data-promptinfo='{ \"title\": \"Write the URL here\", \"text\": \"http://\" }''></button>"
//         quote: "<button id='make_quote' class='make-quote edit-button state-change format-block' rel='formatblock' data-blockformat='BLOCKQUOTE'></button>"
//         heading: """
//           <select id='make_heading' class='make-heading edit-dropdown state-change format-block' rel='formatblock'>
//             <option value='' default selected disabled>Choose Format</option>
//             <option value='h1'>Heading 1</option>
//             <option value='h2'>Heading 2</option>
//           </select>"""
//         removeFormat: "<button id='make_noformat' class='make-noformat edit-button state-change' rel='removeFormat'>Remove Format</button>"
//         makeIntro: "<button id='make_intro' class='make-intro edit-button'>Intro</button>"
//
//       $.each @editElements, (i, val) =>
//         @$editElementsWrap.append(val)
//
//     bindEditElements: ->
//       $('button.edit-button').on 'click.changeState', @editButtonChangeState
//       $('select.edit-dropdown').on 'change.changeState', @editDropdownChangeState
//
//       @$editor.on 'keypress.formatParagraph', @formatParagraphOnKeypress
//       .on 'keyup.formatParagraph', @formatParagraphOnKeyup
//
//     editButtonChangeState: (e) =>
//       e.preventDefault()
//       e.stopPropagation()
//       state = $(e.target).attr('rel')
//
//       if $(e.target).hasClass('has-prompt')
//         promptInfo  = $(e.target).data('promptinfo')
//         promptTitle = promptInfo.title
//         promptText  = promptInfo.text
//         @prompt     = prompt(promptTitle, promptText)
//         if @prompt != '' && @prompt != 'http://'
//           @setState(state, @prompt)
//       else if $(e.target).hasClass('format-block')
//         blockformat = $(e.target).data('blockformat')
//         @setState(state, blockformat)
//       else if $(e.target).hasClass('make-noformat')
//         @setState(state)
//         @setState('formatBlock', 'p')
//       else if $(e.target).hasClass('make-intro')
//         @surroundSelection('span', { id: "post__intro" })
//       else
//         @setState(state)
//
//       @toggleEditElements()
//       @$editor.find('*').each (i, el) =>
//         $(el)[0].classList.add("post__#{el.nodeName.toLowerCase()}")
//       @updateInput()
//       @$editor.focus()
//
//     editDropdownChangeState: (e) =>
//       e.stopPropagation()
//       state       = $(e.target).attr('rel')
//       blockformat = $(e.target).val()
//       @setState(state, blockformat)
//
//     formatParagraphOnKeypress: (e) =>
//       if e.target.innerHTML.replace(/\s/gi, '') == ''
//         @setState('formatBlock', 'p')
//         @$editor.find('p').addClass('post__p')
//
//     formatParagraphOnKeyup: (e) =>
//       if e.keyCode == 13 && !e.shiftKey
//         @setState('formatBlock', 'p')
//         @$editor.find('p').addClass('post__p')
//
//     toggleEditElements: =>
//       $('button.edit-button').removeClass('active')
//       @$editElementsWrap.children().not('.format-block').each (i, el) =>
//         $(el).removeClass('active')
//         elState = $(el).attr('rel')
//         state   = @getState(elState)
//         if state then $(el).addClass('active')
//
//       node = window.getSelection().anchorNode.parentNode
//       while node.nodeName != 'DIV' && node.id != 'edit_elements_wrap'
//         $('button.format-block[data-blockformat='+node.nodeName+']').addClass('active')
//         node = node.parentNode
//
//     watchSelection: ->
//       @$editor.on 'click.watchSelection keyup.watchSelection', @toggleEditElements
//
//     createSnippet: ->
//       @$editor.on 'blur.createSnippet', @populateSnippet
//
//     populateSnippet: =>
//       document.getElementById('post_snippet').value = @$editor.find('#post__intro').html() || ""
