extends Node

var characters = []
var clothes = {}

func _ready():
    var dir = Directory.new()
    var _file = File.new()
    
    if not dir.dir_exists("user://saves"):
        dir.make_dir("user://saves")
    if not dir.dir_exists("user://characters"):
        dir.make_dir("user://characters")
    
    characters.append(get_tree().current_scene.get_node("Player").profile)

func save():
    var file = File.new()
    var character_save = []
    for scrat in characters:
        character_save.append(scrat.save_to_dict())
    file.open("user://saves/save.json", file.WRITE)
    file.store_line(to_json(character_save))
