Template.home.events
  'click [data-id=sign-out]': (event, template) ->
    Meteor.logout ->
      FlowRouter.go '/sign_in'
