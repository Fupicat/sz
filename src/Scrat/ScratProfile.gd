extends Resource
class_name ScratProfile

export(String) var name
export(int) var money
export(Array, Resource) var inventory

func _init(p_name = "", p_money = 0, p_inventory = []):
    name = p_name
    money = p_money
    inventory = p_inventory

func is_saved_to_disk():
    var path_no_res = resource_path.replace("res://", "")
    var path_ok = not (resource_path.empty() or ":" in path_no_res)
    return path_ok

func save_to_dict():
    # Save all inventory items into dictionaries
    var inventory_save = []
    for item in inventory:
        inventory_save.append(item.save_to_dict())
    
    var save_data = {
        "name": name,
        "money": money,
        "inventory": inventory_save,
    }
    
    # If character exists on disk, save the path along with the other stuff
    # Since everything about a character can be changed
    if is_saved_to_disk():
        save_data["path"] = resource_path
    
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
