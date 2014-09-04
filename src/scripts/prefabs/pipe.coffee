class Pipe extends Phaser.Sprite

  constructor: (game, x, y, frame)->
    Phaser.Sprite.call(@, game, x, y, 'pipe', frame)
    @anchor.setTo(0.5, 0.5)
    @game.physics.arcade.enableBody(@)

    @body.allowGravity = false
    @body.immovable = true

module.exports = Pipe
