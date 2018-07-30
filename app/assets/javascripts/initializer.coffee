Translator.Initializer =
  exec: (pageName) ->
    if pageName && Translator[pageName]
      Translator[pageName]['init']()

  currentPage: ->
    return '' unless $('body').attr('id')

    bodyIds     = $('body').attr('id').split('_')
    pageName    = ''
    for bodyId in bodyIds
      pageName += Translator.Util.capitalize(bodyId)
    pageName

  init: ->
    Translator.Initializer.exec('Common')
    if @currentPage()
      Translator.Initializer.exec(@currentPage())

$(document).ready ->
  Translator.Initializer.init()