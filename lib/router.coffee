FlowRouter.notfound =
  action: ->
    FlowLayout.render 'notFound'

FlowRouter.route '/',
  action: ->
    setTitle i18n 'home'
    FlowLayout.render 'layout', main: 'home'

FlowRouter.route '/sign_in',
  action: ->
    setTitle i18n 'signIn'
    FlowLayout.render 'layout', main: 'signIn'

FlowRouter.route '/sign_up',
  action: ->
    setTitle i18n 'signUp'
    FlowLayout.render 'layout', main: 'signUp'

# check user permissions
if Meteor.isClient
  Tracker.autorun ->
    if FlowRouter.reactiveCurrent().path is '/' and !Meteor.userId()
      FlowRouter.go '/sign_in'
    else if (FlowRouter.reactiveCurrent().path is '/sign_in' or FlowRouter.reactiveCurrent().path is '/sign_up') and Meteor.userId()
      FlowRouter.go '/'
