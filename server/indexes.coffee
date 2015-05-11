Meteor.startup ->
  Tags._ensureIndex 'userId': 1
  Tags._ensureIndex 'name': 1
  News._ensureIndex 'tags': 1
  News._ensureIndex 'url': 1
