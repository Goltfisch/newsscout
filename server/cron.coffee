SyncedCron.add
  name: 'Fetch latest Google News for all stored tags'
  schedule: (parser) ->
    parser.text 'every 30 minutes'
  job: ->
    Meteor.call 'fetchGoogleNews'

SyncedCron.add
  name: 'Scrape RSS-Feeds'
  schedule: (parser) ->
    parser.text 'every 30 minutes'
  job: ->
    Meteor.call 'scrapeRSSFeeds'
