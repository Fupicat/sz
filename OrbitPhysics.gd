extends KinematicBody2D
class_name OrbitPhysics

const GRV = 2000

var grv_multiply = 1
var move = Vector2()

onready var planet = get_parent().get_node("Planet")

func _physics_process(delta):
    gravity_step(delta)

func gravity_step(delta):
    # Direct objects's bottom towards the center of the planet.
    # Or downwards if no planet is found.
    rotation = 0
    if planet:
        look_at(planet.position)
        rotate(deg2rad(-90))
    
    # Apply gravity if no floor under physics object
    if is_on_floor():
        move.y = 0
    else:
        move.y += GRV * delta

func apply_movement():
    var moverot = move.rotated(rotation)
    var updir = Vector2(0, -1).rotated(rotation)
    var snap = Vector2(0, 10).rotated(rotation)
    
    var _err = move_and_slide_with_snap(moverot, snap, updir)
