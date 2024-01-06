extends GridEx

class_name Import

static func import_group_tile_automatic(path: String) -> void:
	var tile_menu: PackedScene = preload("res://Scene/Theme_Tile/Basic.tscn")
	
	var scene = load(path)
	var no = scene.instance()
	
	var basic = tile_menu.instance()
	
	basic.tittle = no.name
	basic.group_scene = scene
	Index.edit_node.Tile_groups.add_child(basic)
