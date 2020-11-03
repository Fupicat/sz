extends Resource
class_name ScratProfile

export(String) var name
export(int) var money
export(Array, Resource) var inventory

func _init(p_name = "", p_money = 0, p_inventory = []):
    name = p_name
    money = p_money
    inventory = p_inventory

func save_to_dict():
    # Save all inventory items into dictionaries
    var inventory_save = []
    for item in inventory:
        if item.is_saved_to_disk():
            inventory_save.append(item.save_file_path())
        else:
            inventory_save.append(item.save_to_dict())
    
    # Make dictionary that will be saved for this character
    var save_data = {
        "name": name,
        "money": money,
        "inventory": inventory_save,
       }
    return save_data

func load_from_dict(dict : Dictionary):
    # Load all inventory items from dicts
    var inventory_load = []
    for item in dict["inventory"]:
        
        # If the saved inventory item has a path, just load the item from disk
        if "path" in item.keys():
            inventory_load.append(load(item["path"]))
        # If it doesn't, create a new item with the info
        # Might remove later, don't know if this will be used
        else:
            var inv_item = load("res://Items/" + item["type"] + ".gd").new()
            inventory_load.append(inv_item.load_from_dict(item))
    
    _init(dict["name"], dict["money"], inventory_load)
