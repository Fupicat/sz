extends Resource
class_name ScratProfile

export(String) var name
export(int) var money
export(Array, Resource) var inventory

func _init(p_name = "", p_money = 0, p_inventory = []):
    name = p_name
    money = p_money
    inventory = p_inventory
