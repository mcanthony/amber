{View, $} = require "space-pen"
{T} = require "am/util"

class Discuss extends View
  @content: ->
    @article =>
      @h1 T("Discuss Amber")
      tags = "announcement,suggestion,bug,request,question,help,extension".split ","
      for i in [1..50]
        @section class: "topic #{if i < 6 then "unread" else ""}", =>
          @button class: "star", click: "star", title: T("Star")
          @button class: "read", click: "read", title: T("Mark as read")
          @a class: "name", href: "/topic/#{i}", =>
            @strong "The name of topic ##{i}"
            has = {}
            for x in [1..10] when (t = tags[Math.random() * 100 | 0]) and not has[t]
              @span class: "tag tag-#{t}", t
              has[t] = yes
          @div class: "subtitle", =>
            name = "nathan"
            url = "/#{name}"
            time = "10 minutes ago"
            @raw T("<a href=\"{url}\">{name}</a> created {time}", {url, name, time})

  star: (e, el) ->
    el.closest(".topic").toggleClass "starred"

  read: (e, el) ->
    el.closest(".topic").removeClass "unread"

module.exports = {Discuss}
