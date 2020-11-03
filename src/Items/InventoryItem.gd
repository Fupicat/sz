extends Resource
class_name InventoryItem

export(String) var name
export(Texture) var icon

func _init(p_name := "",
        p_icon = load("res://Items/Clothes/Head/Bald.png")):
    name = p_name
    icon = p_icon
