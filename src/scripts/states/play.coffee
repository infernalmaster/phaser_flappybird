Bird = require('./../prefabs/bird')
Ground = require('./../prefabs/ground')
Pipe = require('./../prefabs/pipe')
PipeGroup = require('./../prefabs/pipeGroup')
Scoreboard = require('./../prefabs/scoreboard')

class Play

  constructor: (game)->

  create: ->
    @game.physics.startSystem(Phaser.Physics.ARCADE)
    @game.physics.arcade.gravity.y = 1200

    # @background = @game.add.sprite(0,0,'background')
    @background = @game.add.tileSprite(0, 0, 288, 505, 'background')
    @background.autoScroll(-20, 0)



    @bird = new Bird(@game, 100, @game.height/2)
    @game.add.existing(@bird)

    @game.input.keyboard.addKeyCapture([Phaser.Keyboard.SPACEBAR])
    flapKey = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)
    flapKey.onDown.add(@bird.flap, @bird)
    flapKey.onDown.addOnce(@startGame, @)
    @game.input.onDown.add(@bird.flap, @bird)
    @game.input.onDown.addOnce(@startGame, @)


    @ground = new Ground(@game, 0, 400, 335, 112)
    @game.add.existing(@ground)

    @pipes = @game.add.group()

    @score = 0
    @scoreText = @game.add.bitmapText(@game.width/2, 10,
      'flappyfont', @score.toString(), 24)

    @scoreSound = @game.add.audio('score')
    @pipeHitSound = @game.add.audio('pipeHit')
    @groundHitSound = @game.add.audio('groundHit')

    @instructionGroup = @game.add.group()
    @instructionGroup.add(@game.add.sprite(@game.width/2, 100,'getReady'))
    @instructionGroup.add(@game.add.sprite(@game.width/2, 325,'instructions'))
    @instructionGroup.setAll('anchor.x', 0.5)
    @instructionGroup.setAll('anchor.y', 0.5)

    @gameover = false


  update: ->

    @game.physics.arcade.collide(@bird, @ground, @deathHandler, null, @)

    if !@gameover
      @pipes.forEach (pipeGroup)=>
        @checkScore(pipeGroup)
        @game.physics.arcade.collide(@bird, pipeGroup, @deathHandler, null, @)


  deathHandler: (bird, enemy)->

    @ground.stopScroll()

    if enemy instanceof Ground && !@bird.onGround
      @groundHitSound.play()
      @scoreboard = new Scoreboard(@game)
      @game.add.existing(@scoreboard)
      @scoreboard.show(@score)

      @bird.onGround = true

    else
      if enemy instanceof Pipe
        @pipeHitSound.play()

    if !@gameover
      @gameover = true

      @bird.kill()

      @pipes.forEach (pipeGroup)->
        pipeGroup.setAll('body.velocity.x', 0)

      @pipeGenerator.timer.stop()
      @ground.stopScroll()
      @background.stopScroll()

  startGame: ->
    if !@bird.alive && !@gameover

      @bird.body.allowGravity = true
      @bird.alive = true

      @pipeGenerator = @game.time.events
        .loop(Phaser.Timer.SECOND * 1.0, @generatePipes, @)
      @pipeGenerator.timer.start()

      @instructionGroup.destroy()

  checkScore: (pipeGroup)->
    if pipeGroup.exists &&
    !pipeGroup.hasScored && pipeGroup.topPipe.world.x <= @bird.world.x
      pipeGroup.hasScored = true
      @score++
      @scoreText.setText(this.score.toString())
      @scoreSound.play()


  shutdown: ->
    @game.input.keyboard.removeKey(Phaser.Keyboard.SPACEBAR)
    @bird.destroy()
    @pipes.destroy()
    @scoreboard.destroy()

  generatePipes: ->
    pipeY = @game.rnd.integerInRange(-100, 100)
    pipeGroup = @pipes.getFirstExists(false)

    if !pipeGroup
      pipeGroup = new PipeGroup(@game, @pipes)

    pipeGroup.reset(@game.width + pipeGroup.width/2, pipeY)


module.exports = Play
