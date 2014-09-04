class Boot

  preload: ->
    @game.load.image('preloader', './assets/preloader.gif')

  create: ->
    @game.input.maxPointers = 1
    @game.state.start('preload')


module.exports = Boot