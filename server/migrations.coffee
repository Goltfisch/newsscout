Meteor.startup ->
  # update source attribute of news to be string rather than object
  Migrations.add
    version: 1
    up: ->
      News.find().forEach (news) ->
        if news.source and news.source.url
          News.update
            _id: news._id
          ,
            $set:
              sourceUrl: news.source.url

  # remove unused source-Attribute
  Migrations.add
    version: 2
    up: ->
      News.find().forEach (news) ->
        if news.source
          News.update
            _id: news._id
          ,
            $unset:
              source: ''

  # remove hashedUrl-Attribute
  Migrations.add
    version: 3
    up: ->
      News.find().forEach (news) ->
        News.update
          _id: news._id
        ,
          $unset:
            hashedUrl: ''

  Migrations.migrateTo('latest');
