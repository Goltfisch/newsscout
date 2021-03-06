Meteor.publish 'tags', ->
  if @userId
    Tags.find
      userId: @userId
    ,
      sort:
        name: 1
  else
    []

Meteor.publish 'news', (tags, limit) ->
  check tags, Array
  check limit, Number
  if @userId
    News.find
      tags:
        $in: tags
    ,
      sort:
        updatedAt: -1
      limit:
        limit
  else
    []
