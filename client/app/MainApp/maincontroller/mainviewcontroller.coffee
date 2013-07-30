class MainViewController extends KDViewController

  constructor:->

    super

    mainView       = @getView()
    mainController = KD.getSingleton 'mainController'
    @registerSingleton 'mainViewController', @, yes
    @registerSingleton 'mainView', mainView, yes

    mainController.on 'accountChanged.to.loggedIn', (account)=>
      mainController.loginScreen.hide()

    mainController.on "ShowInstructionsBook", (index)=>
      book = mainView.addBook()
      book.fillPage index

    mainController.on "ToggleChatPanel", =>
      mainView.chatPanel.toggle()

  loadView:(mainView)->

    mainView.mainTabView.on "MainTabPaneShown", (pane)=>
      @mainTabPaneChanged mainView, pane

  mainTabPaneChanged:(mainView, pane)->

    cdController    = KD.getSingleton("contentDisplayController")
    appManager      = KD.getSingleton('appManager')
    app             = appManager.getFrontApp()
    {navController} = KD.getSingleton('mainController').sidebarController.getView()
    cdController.emit "ContentDisplaysShouldBeHidden"
    @setViewState pane.getOptions()

    navController.selectItemByName app.getOption('navItem').title

  setViewState: do ->

    isEntryPointSet = null

    (options)->

      {behavior, name} = options

      isEntryPointSet = yes if name isnt "Home"

      {contentPanel, mainTabView, sidebar} = @getView()

      o = {isEntryPointSet, name}

      switch behavior
        when 'hideTabs'
          o.hideTabs = yes
          o.type     = 'social'
        when 'application'
          o.hideTabs = no
          o.type     = 'develop'
        else
          o.hideTabs = no
          o.type     = 'social'

      @emit "UILayoutNeedsToChange", o

      isEntryPointSet = yes
