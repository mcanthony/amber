{urls} = require "am/urls"
{NotFound} = require "am/views/not-found"
{InternalError} = require "am/views/internal-error"

class Router
  constructor: (@app) ->
    app.router = @
    @domain = "#{location.protocol}//#{location.host}"
    @route()
    addEventListener "popstate", @route
    document.addEventListener "click", @navigate

  navigate: (e) =>
    return if e.metaKey or e.shiftKey or e.ctrlKey or e.altKey
    t = e.target
    while t
      if t.tagName is "A"
        if @domain is t.href.slice 0, @domain.length
          e.preventDefault()
          @go t.href
        return
      t = t.parentNode

  go: (url, replace) ->
    scrollTo 0, 0
    @goSilent url, replace
    @route()

  goSilent: (url, replace) ->
    if replace
      history.replaceState null, null, @normalize url
    else
      history.pushState null, null, @normalize url

  normalize: (url) ->
    if url isnt "/" and "/" is url.slice -1 then url.slice 0, -1 else url

  replace: (url) -> @go url, yes
  replaceSilent: (url) -> @goSilent url, yes

  goBack: (fallback) ->
    history.go -1 # TODO use fallback if history is off-site

  route: =>
    target = location.pathname
    targetSegments = target.split "/"
    for pattern, View of urls
      segments = pattern.split "/"
      continue if segments.length isnt targetSegments.length
      match = yes
      slugs = {@app}
      for segment, i in segments
        ts = decodeURIComponent targetSegments[i]
        if ":" is segment.charAt 0
          slugs[segment.slice 1] = ts
        else
          if ts isnt segment
            match = no
            break
      if match
        try
          view = new View slugs
        catch e
          @app.setView new InternalError
            name: e.constructor.name
            message: e.message
            stack: e.stack
          setTimeout -> throw e
          return
        @app.setView view
        return
    @app.setView new NotFound {url: target}

module.exports = {Router}
