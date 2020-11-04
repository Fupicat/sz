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

func _init(p_guid := str(randi()),
        p_name := "",
        p_icon := load("res://Items/Clothes/Head/Bald.png"),
        p_flavor := "",
        p_body_part := body.HEAD):
    guid = p_guid
    name = p_name
    icon = p_icon # Icon doubles as texture for the clothing itself
    flavor = p_flavor
    
    body_part = p_body_part
