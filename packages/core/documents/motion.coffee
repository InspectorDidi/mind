class Motion extends share.BaseDocument
  # createdAt: time of document creation
  # updatedAt: time of the last change
  # lastActivity: time of the last activity on the motion
  # author:
  #   _id
  #   username
  # discussion:
  #   _id
  # body: the latest version of the body
  # changes: list (the last list item is the most recent one) of changes
  #   updatedAt: timestamp of the change
  #   author: author of the change
  #     _id
  #     username
  #   body
  # votingOpenedBy:
  #   _id
  #   username
  # votingOpenedAt: time when voting started
  # votingClosedBy:
  #   _id
  #   username
  # votingClosedAt: time when voting ended
  # withdrawnBy
  # withdrawnAt

  @Meta
    name: 'Motion'
    fields: =>
      author: @ReferenceField User, User.REFERENCE_FIELDS()
      discussion: @ReferenceField Discussion
      # $slice in the projection is not supported by Meteor, so we fetch all changes and manually read the latest entry.
      body: @GeneratedField 'self', ['changes'], (fields) ->
        [fields._id, fields.changes?[fields.changes?.length - 1]?.body or '']
      changes: [
        author: @ReferenceField User, User.REFERENCE_FIELDS()
      ]
      votingOpenedBy: @ReferenceField User, User.REFERENCE_FIELDS(), false
      votingClosedBy: @ReferenceField User, User.REFERENCE_FIELDS(), false
      withdrawnBy: @ReferenceField User, User.REFERENCE_FIELDS(), false
    triggers: =>
      updatedAt: share.UpdatedAtTrigger ['changes']

  @PUBLISH_FIELDS: ->
    _id: 1
    createdAt: 1
    updatedAt: 1
    lastActivity: 1
    author: 1
    discussion: 1
    body: 1
    votingOpenedBy: 1
    votingOpenedAt: 1
    votingClosedBy: 1
    votingClosedAt: 1
    withdrawnBy: 1
    withdrawnAt: 1

  isWithdrawn: ->
    !!(@withdrawnAt and @withdrawnBy)

  isOpen: ->
    !!(@votingOpenedAt and @votingOpenedBy and not @votingClosedAt and not @votingClosedBy and not @isWithdrawn())

  isClosed: ->
    !!(@votingOpenedAt and @votingOpenedBy and @votingClosedAt and @votingClosedBy and not @isWithdrawn())
