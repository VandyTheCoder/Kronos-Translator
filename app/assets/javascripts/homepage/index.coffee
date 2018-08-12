Translator.HomepageIndex =
  init: ->
    @_initTooltip()
    @_handleLanguageButton()
    @_handleChangeLanguageButton()
    @_handleCopyButton()
    @_subcribedChannelTranslator()
    @_handleInputChangeInTextArea()

  _initTooltip: ->
    $('[data-toggle="tooltip"]').tooltip()    

  _handleLanguageButton: ->
    self = @
    output_language = $("#output-language")
    $("#kh-button").click ->
      output_language.html("<img src='/en.png' alt='kh' width='15' height='10'> Khmer")
      self._exchangeValueOfTextArea()
      
    $("#en-button").click ->
      output_language.html("<img src='/kh.png' alt='en' width='15' height='10'> English")
      self._exchangeValueOfTextArea()

  _handleChangeLanguageButton: ->
    change_btn = $('#change-language')
    change_btn.click ->
      language = $("input[name=input-language]:checked").val()
      output_language = $("#output-language")
      if language == "en"
        $("#kh-button").click()
        output_language.html("<img src='/en.png' alt='kh' width='15' height='10'> Khmer")
      else
        $("#en-button").click()
        output_language.html("<img src='/kh.png' alt='en' width='15' height='10'> English")

  _handleCopyButton: ->
    self = @
    $('#copy-button').click ->
      self._handleTooltip()
      $('#copy-button').attr('data-original-title', "Copied to Clipboard").tooltip('show')
      temp = $('<input>')
      $('body').append temp
      temp.val($("#second-textarea").val()).select()
      document.execCommand 'copy'
      temp.remove()
  
  _handleTooltip: ->
    $("#copy-button").mouseleave ->
      $('#copy-button').tooltip('hide').attr('data-original-title', "Copy to Clipboard")

  _subcribedChannelTranslator: ->
    self = @
    room_id = (new Date).getTime()
    AppCable.rails_translator = AppCable.cable.subscriptions.create {channel: "RailsTranslatorChannel", room_id: room_id} ,
      connected: ->
        console.log "Connected To Translator Channel " + room_id

      disconnected: ->
        console.log "Connected Disconnected Translator Channel" + room_id

      received: (data) ->
        self._returnResult(data["result"])

      translate: (data)->
        @perform 'translate', input: data["input"], language: data["language"]

  _returnResult: (result) ->
    secondTextarea = $('#second-textarea')
    secondTextarea.val(result)

  _handleInputChangeInTextArea: ->
    $('#first-textarea').on 'change keyup paste', ->
      language = $("input[name=input-language]:checked").val()
      data = {input: $(this).val(), language: language}
      AppCable.rails_translator.translate(data)

  _exchangeValueOfTextArea: ->
    firstTextarea = $('#first-textarea')
    secondTextarea = $('#second-textarea')

    temp_result = firstTextarea.val().replace(/(\r\n\t|\n|\r\t)/gm,"")
    firstTextarea.val(secondTextarea.val().replace(/(\r\n\t|\n|\r\t)/gm,""))
    secondTextarea.val(temp_result)