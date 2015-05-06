Meteor.startup ->
  i18n.setLanguage getLocale()

  sAlert.config
    effect: 'scale'
    position: 'left-bottom'
    timeout: 5000
