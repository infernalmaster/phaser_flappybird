class Bird extends Phaser.Sprite
  constructor: (game, x, y, frame)->
    Phaser.Sprite.call(@, game, x, y, 'bird', frame)

    @anchor.setTo(0.5, 0.5)
    @animations.add('flap')
    @animations.play('flap', 12, true)


    @game.physics.arcade.enableBody(@)
    @body.allowGravity = false
    @alive = false

    @checkWorldBounds = true
    @outOfBoundsKill = true

    @flapSound = @game.add.audio('flap')

    @events.onKilled.add(@onKilled, @)


  flap: ->
    if !!this.alive
      @flapSound.play()
      @body.velocity.y = -400
      @game.add.tween(@).to({angle: -40}, 100).start()

  update: ->
    if @angle < 90 and @alive
      @angle += 2.5

    if !@alive
      @body.velocity.x = 0

  onKilled: ->
    @exists = true
    @visible = true
    @animations.stop()

    duration = 90 / @y * 300

    @game.add.tween(@).to({angle: 90}, duration).start()




module.exports = Bird
