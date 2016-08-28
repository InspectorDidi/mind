class Discussion.ListComponent extends UIComponent
  @register 'Discussion.ListComponent'

  onCreated: ->
    super

    @canNew = new ComputedField =>
      User.hasPermission User.PERMISSIONS.DISCUSSION_NEW

    @subscribe 'Meeting.list'
    @subscribe 'Discussion.list'

  discussionsWithoutMeeting: ->
    Discussion.documents.find
      # Discussions which do not have even the first meeting list item.
      'meetings.0':
        $exists: false
    ,
      sort:
        # The newest first.
        createdAt: -1

class Discussion.ListItemComponent extends UIComponent
  @register 'Discussion.ListItemComponent'

  displayStatus: ->
    data = @data()
    if data?.status is Discussion.STATUS.DRAFT
      "drafting discussion"
    else if data?.status is Discussion.STATUS.OPEN
      "discussion"
    else if data?.status is Discussion.STATUS.MOTIONS
      "drafting motions"
    else if data?.status is Discussion.STATUS.VOTING
      "voting open"
    else if data?.status is Discussion.STATUS.CLOSED
      "closed"

FlowRouter.route '/',
  name: 'Discussion.list'
  action: (params, queryParams) ->
    BlazeLayout.render 'MainLayoutComponent',
      main: 'Discussion.ListComponent'

    share.PageTitle "Discussions"
