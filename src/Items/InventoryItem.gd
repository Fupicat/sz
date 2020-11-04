extends Resource
class_name InventoryItem

export(String) var guid
export(String) var name
export(Texture) var icon
export(String) var flavor

func _init(p_guid := randi(),
        p_name := "",
        p_icon := load("res://Items/Clothes/Head/Bald.png"),
        p_flavor := ""):
    guid = p_guid
    name = p_name
    icon = p_icon
    flavor = p_flavor
