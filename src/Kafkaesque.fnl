(local utils (require :src.utils))

(var state (require :src.state))

; METHODS

(fn addfood [game]
    (let [Food (require :src.food)]
        (for [i 1 game.NUM_FOOD]
            (tset game.objects (+ 1 (length game.objects))
                (Food.new :flower (math.random 0 game.WORLD_WIDTH) (math.random 0 game.WORLD_HEIGHT) game.world.physics)
            )
        )
    )
)

(fn addcreatures [game]
    (let [Creep (require :src.creature)]
        (for [i 1 game.NUM_FOOD]
            (tset game.objects (+ 1 (length game.objects))
                (Creep.new :ant (math.random 0 game.WORLD_WIDTH) (math.random 0 game.WORLD_HEIGHT) game.world.physics)
            )
        )
    )
)

; UPDATE

(fn update [self dt]
    
    ; update starving -- have to do it like this so that it updates the state in game properly :(((
    ((. (. self.objects 1) :starving) (. self.objects 1) dt)
    ; check if lose
    (if (< (. (. self.objects 1) :hunger) 0)
        ; change state
        (set state.current "HOME")

    )

    ; world update
    (self.world:update dt)

    ; object update 
    (utils.tmapupdate self.objects dt)
)

; DRAW

(fn draw [self] 
    
    ; draw world
    (self.world:drawmap)

    ; draw all objects
    (self.world:draw self.objects)

    ; draw HUD
    (self.hud.draw (. self.objects 1)) ; pass hero

)

; CONFIGURATION, INTERFACE AND DEFAULTS

(local InitState {

    ; Class instances
    :world nil    
    :objects nil
    :hud nil

    ; Initial values
    :X_INIT 2000
    :Y_INIT 2000
    :WORLD_HEIGHT 4000
    :WORLD_WIDTH 4000

    ; Configuration
    :NUM_FOOD 10
    :NUM_CREATURES 10


    ; METHODS

    :draw draw
    :update update
})


; CONSTRUCTOR / NEW GAME

(fn newgame []
    (let [
            World (require :src.world)
            Hero (require :src.hero)
            HUD (require :src.hud)

            objects []
            game (utils.tcopy InitState)
        ]
        ; new world
        (tset game :world (World.new game.X_INIT game.Y_INIT))

        ; add hero
        (tset objects 1 (Hero.new game.X_INIT game.Y_INIT game.world))

        ; bind objects
        (tset game :objects objects)

        ; add creatures
        (addcreatures game)

        ; add food
        (addfood game)    

        ; bind hud
        (tset game :hud HUD)

        ; return
        game
    )
)


; EXPORTS

{
    :newgame newgame ; initializes a game state
}