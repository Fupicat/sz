extends Resource
class_name InventoryItem

export(String) var name
export(Texture) var icon

func _init(p_name := "",
        p_icon = load("res://Items/Clothes/Head/Bald.png")):
    name = p_name
    icon = p_icon

func save_to_dict():
    var save_data = {
        "type": "InventoryItem",
        "name": name,
        "icon": icon.load_path,
       }
    return save_data

func load_from_dict(dict : Dictionary):
    _init(dict["name"], dict["icon"])
