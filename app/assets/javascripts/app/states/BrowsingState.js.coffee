#= require app/mediators/authenticationMediator

App = this.App

App.states.BrowsingState = SC.State.extend {

  initialSubstate: 'Public'

  Public: SC.State.extend {

    initialSubstate: 'ListNotes'

    ListNotes: SC.State.extend {

      representRoute: 'notes'

      createNote: ->
        @gotoState 'Browsing.Restricted.CreateNote'
    }
  }

  Restricted: SC.State.extend {

    initialSubstate: 'CreateNote'

    beforeFilter: (context) ->
      unless App.mediators.authenticationMediator.get('loggedIn')
        @get('statechart').send('login')
        return false

      return true

    CreateNote: SC.State.extend {
      representRoute: 'notes/create'
    }

    logout: ->
      @gotoState 'Browsing.Public.ListNotes'
  }

}