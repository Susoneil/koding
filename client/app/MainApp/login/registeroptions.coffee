class RegisterOptions extends KDView
  viewAppended:->
    @addSubView new KDHeaderView
      type     : "small"
      title    : "YOU NEED AN INVITATION CODE TO REGISTER."

    @addSubView optionsHolder = new KDCustomHTMLView
      tagName  : "ul"
      cssClass : "login-options"

    optionsHolder.addSubView new KDCustomHTMLView
      tagName  : "li"
      cssClass : "koding active"
      partial  : "koding"
      tooltip  :
        title  : "<p class='login-tip'>Register with Koding</p>"

    optionsHolder.addSubView new KDCustomHTMLView
      tagName  : "li"
      cssClass : "github active"
      partial  : "github"
      click    : -> KD.utils.openGithubPopUp()
      tooltip  :
        title  : "<p class='login-tip'>Register with GitHub</p>"
