{Block} = require "./block"

class CommandBlock extends Block
  isCommand: true
  @type "c"

  insert: (script) ->
    @parent.insertBefore script, this

  outset: -> left: 0, right: 0, top: 0, bottom: 3
  padding: -> left: 7, right: 7, top: 3, bottom: 3
  params: -> pw: 10, px: 16, r: @outset().bottom

  pathOn: (cx, w, h) ->
    {pw, px, r} = @params()
    cx.moveTo 0, r
    cx.lineTo r, 0
    cx.lineTo px - r + .25, 0
    cx.lineTo px + .25, r
    cx.lineTo px + pw - .25, r
    cx.lineTo px + pw + r - .25, 0
    cx.lineTo w - r, 0
    cx.lineTo w, r
    cx.lineTo w, h - r
    cx.lineTo w - r, h
    cx.lineTo px + pw + r, h
    cx.lineTo px + pw, h + r
    cx.lineTo px, h + r
    cx.lineTo px - r, h
    # cx.lineTo px + pw + r, h
    # cx.lineTo px + pw, h + r
    # cx.lineTo px, h + r
    # cx.lineTo px - r, h
    cx.lineTo r, h
    cx.lineTo 0, h - r
    cx.closePath()

  pathOutlineOn: (cx, w, h) ->
    {pw, px, r} = @params()
    cx.translate 0, -.5
    cx.lineTo w, h - r
    cx.lineTo w - r, h
    cx.lineTo px + pw + r, h
    cx.lineTo px + pw, h + r
    cx.lineTo px, h + r
    cx.lineTo px - r, h
    # cx.lineTo px + pw + r, h
    # cx.lineTo px + pw, h + r
    # cx.lineTo px, h + r
    # cx.lineTo px - r, h
    cx.lineTo r, h
    cx.lineTo 0, h - r
    cx.translate 0, .5

  # pathOn: (cx) ->
  #   r = 3
  #   pw = 10
  #   px = 16
  #   out = @outset()
  #   cx.arc r, r, r, Math.PI, Math.PI*3/2
  #   cx.lineTo px, 0
  #   cx.arc px + r, out.bottom - r, r, Math.PI, Math.PI/2, true
  #   cx.arc px + pw - r, out.bottom - r, r, Math.PI/2, 0, true
  #   cx.lineTo px + pw, 0
  #   cx.arc @w - r, r, r, Math.PI*3/2, 0
  #   cx.arc @w - r, @h - r, r, 0, Math.PI/2
  #   cx.lineTo px + pw, @h
  #   cx.arc px + pw - r, @h + out.bottom - r, r, 0, Math.PI/2
  #   cx.arc px + r, @h + out.bottom - r, r, Math.PI/2, Math.PI
  #   cx.lineTo px, @h
  #   cx.arc r, @h - r, r, Math.PI/2, Math.PI
  #   cx.fill()

module.exports = {CommandBlock}
