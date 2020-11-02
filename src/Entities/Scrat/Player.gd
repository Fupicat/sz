extends Scrat

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
            scrat.eyes_look_at(get_global_mouse_position())
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
            scrat.eyes_look_at(get_global_mouse_position())
        else:
            scrat.eyes_look_at()
        
    # Move camera to front of character
    $Focus.position.x = move.x / 5
    
    apply_movement()
    
    scrat.animtree.advance(delta)

func _input(event):
    var sm = scrat.animtree[scrat.action_sm]
    
    if event.is_action_pressed("down"):
        if not acting and not freeze:
            freeze = true
            acting = true
            scrat.play_one_shot("Dance")
        elif sm.get_current_node() == "Dance":
            freeze = false
            acting = false
            scrat.play_one_shot("ActionDone")
    if event.is_action_pressed("action") and not acting:
        acting = true
        freeze = true
        if scrat.material.get_shader_param("dissolve_amount") == 0:
            scrat.play_one_shot("TeleportOut")
            yield(scrat, "action_done")
        else:
            scrat.play_one_shot("TeleportIn")
            yield(scrat, "action_done")
            freeze = false
        acting = false
