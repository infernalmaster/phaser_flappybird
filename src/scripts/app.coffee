window.onload = ->
  BootState = require('./states/boot')
  MenuState = require('./states/menu')
  PlayState = require('./states/play')
  PreloadState = require('./states/preload')


  game = new Phaser.Game(288, 505, Phaser.AUTO, 'game')


  game.state.add('boot', BootState)
  game.state.add('menu', MenuState)
  game.state.add('play', PlayState)
  game.state.add('preload', PreloadState)


  game.state.start('boot')