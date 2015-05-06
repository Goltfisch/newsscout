Template.home.events
  'submit [data-id=add-tag-form]': (event, template) ->
    event.preventDefault()

    tag =
      name: template.find('[data-id=tag]').value

    Meteor.call 'addTag', tag, (error) ->
      if error
        sAlert.error i18n error.reason
      else
        template.find('[data-id=tag]').value = ''

  'mouseenter ul.tag-list > li': (event, template) ->
    $('[data-document-id=' + @_id + ']').show()

  'mouseleave ul.tag-list > li': (event, template) ->
    $('[data-document-id=' + @_id + ']').hide()

  'click [data-id=remove-tag]': (event, template) ->
    if confirm i18n 'removeTagConfirmation'
      Meteor.call 'removeTag', @, (error) ->
        if error
          sAlert.error i18n error.reason

Template.home.helpers
  tags: ->
    Tags.find {}
    ,
      sort:
        name: 1

  news: ->
    News.find {}
    ,
      sort:
        updatedAt: -1

  getHostnameFromUrl: (url) ->
    parser = document.createElement('a')
    parser.href = url
    parser.hostname.replace('www.', '')

Template.home.onCreated ->
  self = @

  self.autorun ->
    tags = []
    if Tags?
      Tags.find().forEach (tag) ->
        tags.push tag.name

    self.tagsSubscriptionHandle = Meteor.subscribe 'tags'
    self.newsSubscriptionHandle = Meteor.subscribe 'news', tags
