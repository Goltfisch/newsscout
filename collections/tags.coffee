@Tags = new Mongo.Collection 'tags'

Meteor.methods
  addTag: (tag) ->
    throw new Meteor.Error(401, 'notSignedIn') unless Meteor.user()
    throw new Meteor.Error(422, 'tagIsBlank') unless tag.name

    isTagExisting = Tags.findOne name: tag.name, userId: Meteor.userId()

    unless isTagExisting
      Tags.insert
        name: tag.name.toLowerCase()
        userId: Meteor.userId()

  removeTag: (tag) ->
    throw new Meteor.Error(401, 'notSignedIn') unless Meteor.user()
    throw new Meteor.Error(403, 'missingPermission') unless tag.userId is Meteor.userId()
    throw new Meteor.Error() unless tag._id

    Tags.remove _id: tag._id

Tags.before.insert (userId, document) ->
  document.createdAt = new Date()
