class Ground extends Phaser.TileSprite

  constructor: (game, x, y, width, height)->
    Phaser.TileSprite.call(@, game, x, y, width, height, 'ground')
    @autoScroll(-200,0)

    @game.physics.arcade.enableBody(@)

    @body.allowGravity = false
    @body.immovable = true


module.exports = Ground
