SyncedCron.add
  name: 'Fetch latest Google News for all stored tags'
  schedule: (parser) ->
    parser.text 'every 30 minutes'
  job: ->
    fetchGoogleNews()

SyncedCron.add
  name: 'Scrape RSS-Feeds'
  schedule: (parser) ->
    parser.text 'every 30 minutes'
  job: ->
    scrapeRSSFeeds()

fetchGoogleNews = ->
  uniqueTags = _.uniq(_.pluck Tags.find().fetch(), 'name')
  uniqueTags.forEach (tag) ->
    result = HTTP.get 'https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=8&q=' + tag
    if result.statusCode is 200 and result.data.responseStatus is 200
      _.each result.data.responseData.results, (result) ->
        News.upsert
          url: result.unescapedUrl
        ,
          $set:
            title: result.titleNoFormatting
            url: result.unescapedUrl
            sourceUrl: 'http://news.google.com'
            updatedAt: new Date()
          $addToSet:
            tags: tag

scrapeRSSFeeds = ->
  feeds = [
    'http://feeds.feedburner.com/businessinsider'
    'http://www.spiegel.de/schlagzeilen/index.rss'
    'http://feeds.reuters.com/reuters/businessNews'
    'http://feeds.feedburner.com/TechCrunch/'
    'http://www.forbes.com/real-time/feed2/'
    'http://feeds.feedburner.com/entrepreneur/latest'
    'http://www.bloomberg.com/feed/bview/'
    'http://newsfeed.zeit.de/all'
    'http://www.faz.net/rss/aktuell/'
  ]

  _.each feeds, (feed) ->
    items = Scrape.feed(feed).items
    _.each items, (item) ->
      # normalize all tags
      tags = _.map item.tags, (tag) -> tag.toLowerCase()
      News.upsert
        url: item.link
      ,
        $set:
          title: item.title
          url: item.link
          sourceUrl: feed
          updatedAt: new Date()
        $addToSet:
          tags:
            $each: tags
