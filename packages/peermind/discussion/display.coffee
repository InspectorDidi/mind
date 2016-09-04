class Discussion.DisplayComponent extends Discussion.OneComponent
  @register 'Discussion.DisplayComponent'

  renderMetadataTimestamp: (parentComponent, metadataComponent) ->
    Discussion.MetadataTimestampComponent.renderComponent parentComponent

class Discussion.MetadataTimestampComponent extends UIComponent
  @register 'Discussion.MetadataTimestampComponent'

class Discussion.EditFormComponent extends UIComponent
  @register 'Discussion.EditFormComponent'

  onRendered: ->
    super

    Materialize.updateTextFields()

    Tracker.afterFlush =>
      # A bit of mangling to get cursor to focus at the end of the text.
      $title = @$('[name="title"]')
      title = $title.val()
      $title.focus().val('').val(title)

  canOnlyEdit: (args...) ->
    @callAncestorWith 'canOnlyEdit', args...

  canEditClosed: (args...) ->
    @callAncestorWith 'canEditClosed', args...

FlowRouter.route '/discussion/:_id',
  name: 'Discussion.display'
  action: (params, queryParams) ->
    BlazeLayout.render 'ColumnsLayoutComponent',
      main: 'Discussion.DisplayComponent'
      first: 'Comment.ListComponent'
      second: 'Point.ListComponent'
      third: 'Motion.ListComponent'

    # We set PageTitle after we get discussion title.
