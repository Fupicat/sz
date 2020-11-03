extends Resource
class_name InventoryItem

export(String) var name
export(Texture) var icon

func _init(p_name := "",
        p_icon = load("res://Items/Clothes/Head/Bald.png")):
    name = p_name
    icon = p_icon

func save_to_dict():
    var save_data
    # If the item exists on disk, just save the path
    if is_saved_to_disk():
        save_data = {
            "path": resource_path,
        }
    # If it doesn't, a new item will be created on load
    else:
        save_data = {
            "type": "InventoryItem",
            "name": name,
            "icon": icon.load_path,
        }
    return save_data

func load_from_dict(dict : Dictionary):
    _init(dict["name"], dict["icon"])

func is_saved_to_disk():
    var path_no_res = resource_path.replace("res://", "")
    var path_ok = not (resource_path.empty() or ":" in path_no_res)
    return path_ok
