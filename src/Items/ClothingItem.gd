extends InventoryItem
class_name ClothingItem

enum body {
    HEAD,
    BODY,
    PANTS,
    HANDS,
    FEET
   }

export(body) var body_part

func _init(p_name = "",
        p_icon = load("res://Items/Clothes/Head/Bald.png"),
        p_body_part = body.HEAD):
    name = p_name
    
    # Icon doubles as texture for the clothing itself
    icon = p_icon
    body_part = p_body_part

func save_to_dict():
    var save_data = {
        "type": "ClothingItem",
        "name": name,
        "icon": icon.load_path,
        "body_part": body_part,
       }
    return save_data

func load_from_dict(dict : Dictionary):
    _init(dict["name"], dict["icon"], dict["body_part"])
