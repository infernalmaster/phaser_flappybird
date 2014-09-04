class Menu


  create: ->
    # @background = @game.add.sprite(0, 0, 'background')
    @background = @game.add.tileSprite(0, 0, 288, 505, 'background')
    @background.autoScroll(-20, 0)

    @ground = @game.add.tileSprite(0, 400, 335, 112, 'ground')
    @ground.autoScroll(-200, 0)


    # STEP 1
    # create a group to put the title assets in
    # so they can be manipulated as a whole
    @titleGroup = @game.add.group()

    # STEP 2
    # create the title sprite
    # and add it to the group
    @title = @game.add.sprite(0,0,'title')
    @titleGroup.add(@title)

    # STEP 3
    # create the bird sprite
    # and add it to the title group
    @bird = @game.add.sprite(200,5,'bird')
    @titleGroup.add(@bird)

    # STEP 4
    # add an animation to the bird
    # and begin the animation
    @bird.animations.add('flap')
    @bird.animations.play('flap', 12, true)

    # STEP 5
    # Set the originating location of the group
    @titleGroup.x = 30
    @titleGroup.y = 100

    # STEP 6
    # create an oscillating animation tween for the group
    @game.add.tween(@titleGroup)
      .to({y:115}, 350, Phaser.Easing.Linear.NONE, true, 0, 1000, true)


    # add our start button with a callback
    @startButton = @game.add
      .button(@game.width/2, 300, 'startButton', @startClick, @)
    @startButton.anchor.setTo(0.5,0.5)




  startClick: ->
    @game.state.start('play')


  update: ->



module.exports = Menu
