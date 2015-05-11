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

  'click [data-id=remove-tag]': (event, template) ->
    if confirm i18n 'removeTagConfirmation'
      Meteor.call 'removeTag', @, (error) ->
        if error
          sAlert.error i18n error.reason

  'click [data-id=tag]': (event, template) ->
    selectedTagsArray = []

    _.each template.findAll('input:checked'), (tag) ->
      selectedTagsArray.push tag.value

    template.selectedTags.set(selectedTagsArray)

  'click [data-id=load-more]': (event, template) ->
    event.preventDefault()
    template.newsSubscriptionHandle.loadNextPage()

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

  tagInSelectedTags: (tag) ->
    _.contains Template.instance().selectedTags.get(), tag

  allNewsLoaded: ->
    handle = Template.instance().newsSubscriptionHandle
    News.find().count() < handle.loaded()

Template.home.onCreated ->
  @selectedTags = new ReactiveVar([])

  self = @

  self.autorun ->
    tags = []
    if Tags?
      Tags.find().forEach (tag) ->
        tags.push tag.name
    unless self.selectedTags.get().length is 0
      tags = self.selectedTags.get()

    self.tagsSubscriptionHandle = Meteor.subscribe 'tags'
    self.newsSubscriptionHandle = Meteor.subscribeWithPagination 'news', tags, 50
