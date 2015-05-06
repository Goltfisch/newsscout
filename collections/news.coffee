@News = new Mongo.Collection 'news'

News.before.insert (userId, document) ->
  document.createdAt = new Date()

News.before.update (userId, document, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set or {}
  modifier.$set.updatedAt = new Date()
