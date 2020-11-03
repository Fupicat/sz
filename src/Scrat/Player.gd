extends ScratBase

var acting = false

func _physics_process(delta):
    
    gravity_step(delta)
    
    var leftright = 0
    if not freeze:
        if Input.is_action_pressed("click"):
            # Mouse movement
            var mouse = get_local_mouse_position().x
            if abs(mouse) > 100:
                leftright = clamp(mouse / 1500, -1, 1)
            
            # Look at mouse
            anim.eyes_look_at(get_global_mouse_position())
        else:
            # Keyboard movement
            var left = int(Input.is_action_pressed("left"))
            var right = int(Input.is_action_pressed("right"))
            leftright = right - left
        
    walk_step(leftright)
    
    flip()
    
    if not freeze:
        # Look at mouse
        if Input.is_action_pressed("click"):
            anim.eyes_look_at(get_global_mouse_position())
        else:
            anim.eyes_look_at()
        
    # Move camera to front of character
    $Focus.position.x = move.x / 3
    
    apply_movement()
    
    anim.animtree.advance(delta)

func _input(event):
    pass
