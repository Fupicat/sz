extends OrbitPhysics
class_name ScratBase

const SPD = 1000
const SLP = 0.3

export(Resource) var profile
var freeze = false

onready var anim = $ScratAnim

func walk_step(leftright):
    # Set horizontal movement direction
    # Leftright = -1 is walking left, 1 if walking right
    move.x = lerp(move.x, leftright * SPD, SLP)
    
    # Set walking animation
    anim.blend_walk_idle(range_lerp(abs(move.x), 0, SPD, 0, 1))

func flip():
    if not freeze:
        # Flip character
        if move.x > 0:
            anim.scale.x = 1
        elif move.x < 0:
            anim.scale.x = -1
