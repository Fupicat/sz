extends OrbitPhysics
class_name Scrat

const SPD = 1300
const SLP = 0.3

var freeze = false

onready var scrat = $Scrat

func walk_step(leftright):
    # Set horizontal movement direction
    # Leftright = -1 is walking left, 1 if walking right
    move.x = lerp(move.x, leftright * SPD, SLP)
    
    # Set walking animation
    scrat.blend_walk_idle(range_lerp(abs(move.x), 0, SPD, 0, 1))

func flip():
    if not freeze:
        # Flip character
        if move.x > 0:
            scrat.scale.x = 1
        elif move.x < 0:
            scrat.scale.x = -1
