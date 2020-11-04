extends Resource
class_name ScratProfile

export(String) var guid
export(String) var name
export(int) var money
export(Array, Resource) var inventory
export(String) var bio

func _init(p_guid := str(randi()),
        p_name := "",
        p_money := 0,
        p_inventory := [],
        p_bio := ""):
    guid = p_guid
    name = p_name
    money = p_money
    inventory = p_inventory
    bio = p_bio
