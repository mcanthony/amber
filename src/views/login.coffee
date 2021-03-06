{View} = require "scene"
{T} = require "am/util"

class Login extends View
  @content: ->
    @article =>
      @section class: "login", keydown: "onKeyDown", input: "onInput", =>
        @h1 T("Sign in")
        @input outlet: "username", placeholder: T("Username"), class: "large"
        @input outlet: "password", type: "password", placeholder: T("Password"), class: "large"
        @p outlet: "error", class: "error", style: "display: none", T("Invalid username or password.")
        @button T("Sign in"), class: "large accent", click: "submit"
        @p =>
          @text T("Don’t have an account?")
          @text " "
          @a href: "join", T("Sign up!")

  title: -> T("Sign in")

  initialize: ({@app}) ->
    app.router.goBack "/" if app.server.user
  enter: ->
    @username.focus()

  onKeyDown: (e) ->
    if e.keyCode is 13
      @submit()
      e.preventDefault()

  onInput: ->
    @error.style.display = "none"

  submit: ->
    @username.disabled = @password.disabled = yes
    @app.server.signIn {
      username: @username.value
      password: @password.value
    }, (err) =>
      @username.disabled = @password.disabled = no
      if err
        if err.name is "incorrect"
          @error.style.display = "block"
          @password.select()
        return
      @app.router.goBack "/"

module.exports = {Login}
