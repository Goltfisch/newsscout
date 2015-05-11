Meteor.methods
  signUp: (user) ->
    check user, { email: String, password: String, passwordConfirmation: String }
    throw new Meteor.Error(422, 'emailIsBlank') unless user.email
    throw new Meteor.Error(422, 'passwordIsBlank') unless user.password
    throw new Meteor.Error(422, 'passwordConfirmationIsBlank') unless user.passwordConfirmation
    throw new Meteor.Error(422, 'passwordsDontMatch') if user.password isnt user.passwordConfirmation

    Accounts.createUser email: user.email.toLowerCase().trim(), password: user.password
