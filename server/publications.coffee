Meteor.publish 'tags', ->
  if @userId
    Tags.find
      userId: @userId
    ,
      sort:
        name: 1
  else
    []
