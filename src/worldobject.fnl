
; IMPORTS 
(local utils (require :src.utils))


; METHODS

(fn draw [self px py]
    ; (love.graphics.setColor 255 255 255 255)
    (love.graphics.draw 
        self.image 
        (- self.x px) (- self.y py)
        self.rotation
        1 1 
        self.X_MID self.Y_MID
    )   
)

(fn update [self dt]
    
)

(fn collide [self object]

)

; INTERFACE

(local WorldObject {
    :x 0
    :y 0
    :mass 0
    :rotation 0
    :health 100

    ; IMAGE VALS
    :image "assets/heart.jpg"
    :X_MID 0
    :Y_MID 0

    ; PROPERTIES

    :collidable false
    :draggable false
    :edible false

    ; GEOMETRY
    :hitbox nil
    :collide collide

    :draw draw
    :update update
})

; CONSTRUCTOR

(fn new [objtype x y]
    (let [ instance (utils.tcopy WorldObject)]
 
        ; load image from path
        (utils.tloadimage instance 50 50)

        (set instance.x x)
        (set instance.y y)

        instance
    )
)


; MODULE EXPORTS 

{:new new :WorldObject WorldObject}