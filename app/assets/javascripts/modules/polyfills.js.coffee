# Validity polyfill

if document.createElement('input').validitee is undefined
  class ValidityState
    constructor: ->
      # @customError     = state.customError()
      @patternMismatch = false
      # @rangeOverflow   = state.rangeOverflow()
      # @rangeUnderflow  = state.rangeUnderflow()
      # @stepMismatch    = state.stepMismatch()
      @tooLong         = false
      # @typeMismatch    = state.typeMismatch()
      @valid           = true
      @valueMissing    = false

  class SetValidity
    constructor: (@input) ->
      @$input = $(@input)
      @value = @input.value
      @valid()

    patternMismatch: ->
      pattern = @$input.attr('pattern')
      reg     = new RegExp(pattern)
      return @input.validitee.patternMismatch = (typeof pattern != 'undefined' && pattern != false && reg.test(@value))

    tooLong: ->
      maxLength = @$input.attr('maxlength')
      return @input.validitee.tooLong = (typeof maxLength != 'undefined' && maxLength != false && @value.length > maxLength)

    valid: ->
      return @input.validitee.valid = (!@valueMissing() && !@tooLong() && !@patternMismatch())

    valueMissing: ->
      required = @$input.attr('required')
      return @input.validitee.valueMissing = (typeof required != 'undefined' && required != false && @value.replace(/\s/g, '') == '')

  $(document.body).on 'change.checkValidity', 'input', (e) ->
    input = (e.target)
    new SetValidity(input)

  $(document.body).on 'submit', 'form', (e) ->
    inputs = document.getElementsByTagName('input')
    inputsLength = inputs.length
    for i in [0...inputsLength]
      new SetValidity(inputs[i])

  inputs = document.getElementsByTagName('input')
  inputsLength = inputs.length
  for i in [0...inputsLength]
    inputs[i].validitee = new ValidityState(inputs[i])
    new SetValidity(inputs[i])

  document.createElement = ((create) ->
    return ->
      input = create.apply(this, arguments)
      if input.tagName.toLowerCase() == 'input'
        input.validitee = new ValidityState()
      return input
  )(document.createElement)
