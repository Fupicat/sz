extends Node2D

# warning-ignore:unused_signal
signal action_done

const EYESLIP = 0.2

onready var animtree = $AnimTree
onready var walk_idle_blend = "parameters/walk_idle/blend_position"
onready var idle_sm = "parameters/walk_idle/0/playback"
onready var walk_sm = "parameters/walk_idle/1/playback"
onready var one_shot = "parameters/one_shot/active"
onready var action_sm = "parameters/actions/playback"
onready var eyes_pos = "parameters/eyes_pos/blend_position"

func _ready():
    animtree.active = true
    eyes_look_at()
    material.set_shader_param("dissolve_amount", 0)
    material.get_shader_param("dissolve_texture").noise.period = 0

func walk_idle_state(variation := "Normal"):
    animtree[idle_sm].travel(variation)
    animtree[walk_sm].travel(variation)

func play_one_shot(anim : String):
    animtree[one_shot] = true
    animtree[action_sm].start(anim)

func current_action():
    return animtree[action_sm].get_current_node()

func blend_walk_idle(blend : float):
    animtree[walk_idle_blend] = blend

func eyes_look_at(pos := $Head.to_global(Vector2(500, 0))):
    pos = $Head.to_local(pos)
    pos.x = range_lerp(pos.x, -500, 500, -1, 1)
    pos.y = range_lerp(pos.y, 500, -500, -1, 1)
    var prev = animtree[eyes_pos]
    animtree[eyes_pos] = lerp(prev, pos, EYESLIP)
