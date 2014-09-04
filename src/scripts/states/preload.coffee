class Preload

  constructor: ->
    @ready = false

  preload: ->
    @load.onLoadComplete.addOnce(@onLoadComplete, @)
    @asset = @add.sprite(@game.width/2, @game.height/2, 'preloader')
    @asset.anchor.setTo(0.5, 0.5)
    @load.setPreloadSprite(@asset)

    @load.image('background', '/assets/background.png')
    @load.image('ground', '/assets/ground.png')
    @load.image('title', '/assets/title.png')
    @load.image('startButton', '/assets/start-button.png')

    @load.spritesheet('bird', '/assets/bird.png', 34, 24, 3)

    @load.spritesheet('pipe', '/assets/pipes.png', 54, 320, 2)


    @load.image('instructions', '/assets/instructions.png')
    @load.image('getReady', '/assets/get-ready.png')

    @load.bitmapFont(
      'flappyfont',
      '/assets/flappyfont/flappyfont.png',
      '/assets/flappyfont/flappyfont.fnt'
    )

    @load.audio('score', '/assets/score.wav')
    @load.audio('flap', '/assets/flap.wav')
    @load.audio('pipeHit', '/assets/pipe-hit.wav')
    @load.audio('groundHit', '/assets/ground-hit.wav')


    @load.image('scoreboard', '/assets/scoreboard.png')
    @load.image('gameover', '/assets/gameover.png')
    @load.spritesheet('medals', '/assets/medals.png', 44, 46, 2)
    @load.image('particle', '/assets/particle.png')

  create: ->
    @asset.cropEnabled = false

  update: ->
    if !!@ready
      @game.state.start('menu')

  onLoadComplete: ->
    @ready = true

module.exports = Preload
