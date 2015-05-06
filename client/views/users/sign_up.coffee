Template.signUp.events
  'submit [data-id=sign-up-form]': (event, template) ->
    event.preventDefault()

    user =
      email: template.find('[data-id=email]').value
      password: template.find('[data-id=password]').value
      passwordConfirmation: template.find('[data-id=password-confirmation]').value

    Meteor.call 'signUp', user, (error) ->
      if error
        sAlert.error i18n error.reason
      else
        FlowRouter.go '/sign_in'
