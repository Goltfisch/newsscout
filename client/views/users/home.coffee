Template.home.events
  'click [data-id=sign-out]': (event, template) ->
    Meteor.logout ->
      FlowRouter.go '/sign_in'

  'submit [data-id=add-tag-form]': (event, template) ->
    event.preventDefault()

    tag =
      name: template.find('[data-id=tag]').value

    Meteor.call 'addTag', tag, (error) ->
      if error
        sAlert.error i18n error.reason
      else
        template.find('[data-id=tag]').value = ''

Template.home.helpers
  tags: ->
    Tags.find {}
    ,
      sort:
        name: 1

Template.home.onCreated ->
  self = @

  self.autorun ->
    self.tagsSubscriptionHandle = Meteor.subscribe 'tags'
