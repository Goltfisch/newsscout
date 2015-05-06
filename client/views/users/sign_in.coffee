Template.signIn.events
  'submit [data-id=sign-in-form]': (event, template) ->
    event.preventDefault()

    email = template.find('[data-id=email]').value
    password = template.find('[data-id=password]').value

    Meteor.loginWithPassword email, password, (error) ->
      if error
        sAlert.error i18n 'emailOrPasswordIsWrong' if error.message is 'Incorrect password [403]' or error.message is 'User not found [403]'
      else
        FlowRouter.go '/'
