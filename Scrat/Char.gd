extends KinematicBody2D

const SPD = 1300
const GRV = 2000
const SLP = 0.3

onready var planet = get_parent().get_node("Planet")
onready var scrat = $Scrat

var move = Vector2()
var freeze = false

func _process(delta):
    
    # Direct character's feet towards the center of the planet.
    rotation = 0
    if planet:
        look_at(planet.position)
        rotate(deg2rad(-90))
    
    # Apply gravity if no floor under character
    if is_on_floor():
        move.y = 0
    else:
        move.y += GRV * delta
    
    var leftright = 0
    if not freeze:
        if Input.is_action_pressed("click"):
            # Mouse movement
            var mouse = get_local_mouse_position().x
            if abs(mouse) > 100:
                leftright = clamp(mouse / 1500, -1, 1)
            
            # Look at mouse
            scrat.eyes_look_at(get_global_mouse_position())
        else:
            # Keyboard movement
            var left = int(Input.is_action_pressed("left"))
            var right = int(Input.is_action_pressed("right"))
            leftright = right - left
        
        # Set horizontal movement direction
    move.x = lerp(move.x, leftright * SPD, SLP)
    
    if not freeze:
        # Flip character
        if move.x > 0:
            scrat.scale.x = 1
        elif move.x < 0:
            scrat.scale.x = -1
        
        # Look at mouse
        if Input.is_action_pressed("click"):
            scrat.eyes_look_at(get_global_mouse_position())
        else:
            scrat.eyes_look_at()
        
    # Move camera to front of character
    $Focus.position.x = move.x / 5
    
    # Set walking animation
    scrat.blend_walk_idle(range_lerp(abs(move.x), 0, SPD, 0, 1))
    
    var moverot = move.rotated(rotation)
    var updir = Vector2(0, -1).rotated(rotation)
    var snap = Vector2(0, 10).rotated(rotation)
    
    var _err = move_and_slide_with_snap(moverot, snap, updir)
    
    scrat.animtree.advance(delta)

func _input(event):
    pass
