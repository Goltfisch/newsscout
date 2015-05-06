@getLocale = ->
  locale = window.navigator.userLanguage || window.navigator.language
  if locale.match /de/
    locale = 'de'
  else
    locale = 'en'

@setTitle = (title) ->
  base = 'News Scout'
  if title then document.title = title + ' - ' + base else base
