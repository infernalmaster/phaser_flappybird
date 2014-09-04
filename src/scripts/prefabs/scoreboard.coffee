class Scoreboard extends Phaser.Group

  constructor: (game)->
    Phaser.Group.call(@, game)

    gameover = @create(@game.width / 2, 100, 'gameover')
    gameover.anchor.setTo(0.5, 0.5)

    @scoreboard = @create(@game.width / 2, 200, 'scoreboard')
    @scoreboard.anchor.setTo(0.5, 0.5)

    @scoreText = @game.add
      .bitmapText(@scoreboard.width, 180, 'flappyfont', '', 18)
    @add(@scoreText)

    @bestScoreText = @game
      .add.bitmapText(@scoreboard.width, 230, 'flappyfont', '', 18)
    @add(@bestScoreText)

    # add our start button with a callback
    @startButton = @game
      .add.button(@game.width/2, 300, 'startButton', @startClick, @)
    @startButton.anchor.setTo(0.5,0.5)

    @add(@startButton)

    @y = @game.height
    @x = 0


  show: (score) ->

    # Step 1
    @scoreText.setText score.toString()
    unless not localStorage

      # Step 2
      bestScore = localStorage.getItem("bestScore")

      # Step 3
      if not bestScore or bestScore < score
        bestScore = score
        localStorage.setItem "bestScore", bestScore
    else

      # Fallback. LocalStorage isn't available
      bestScore = "N/A"

    # Step 4
    @bestScoreText.setText bestScore.toString()

    # Step 5 & 6
    if score >= 10 and score < 20
      medal = @game.add.sprite(-65, 7, "medals", 1)
      medal.anchor.setTo 0.5, 0.5
      @scoreboard.addChild medal
    else if score >= 20
      medal = @game.add.sprite(-65, 7, "medals", 0)
      medal.anchor.setTo 0.5, 0.5
      @scoreboard.addChild medal

    # Step 7
    if medal
      emitter = @game.add.emitter(medal.x, medal.y, 400)
      @scoreboard.addChild emitter
      emitter.width = medal.width
      emitter.height = medal.height
      emitter.makeParticles "particle"
      emitter.setRotation -100, 100
      emitter.setXSpeed 0, 0
      emitter.setYSpeed 0, 0
      emitter.minParticleScale = 0.25
      emitter.maxParticleScale = 0.5
      emitter.setAll "body.allowGravity", false
      emitter.start false, 1000, 1000

    @game.add.tween(@).to({y: 0}, 1000, Phaser.Easing.Bounce.Out, true)


  startClick: ->
    @game.state.start('play')


module.exports = Scoreboard
