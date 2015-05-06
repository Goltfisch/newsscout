SyncedCron.add
  name: 'Fetch latest Google News for all stored tags'
  schedule: (parser) ->
    parser.text 'every 1 hour'
  job: ->
    fetchGoogleNews()

fetchGoogleNews = ->
  uniqueTags = _.uniq(_.pluck Tags.find().fetch(), 'name')
  uniqueTags.forEach (tag) ->
    result = HTTP.get 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=8&q=' + tag
    if result.statusCode is 200 and result.data.responseStatus is 200
      _.each result.data.responseData.results, (result) ->
        News.upsert
          hashedUrl: SHA256(result.unescapedUrl)
        ,
          $set:
            title: result.titleNoFormatting
            url: result.unescapedUrl
            hashedUrl: SHA256(result.unescapedUrl)
            source:
              name: 'Google News'
              url: 'http://news.google.com'
            updatedAt: new Date()
          $addToSet:
            tags: tag
