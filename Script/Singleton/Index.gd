extends Node

signal model_tile_selection(mesh)
signal save_project()
signal change_tile()
signal height_tile(height)
signal grid_size(size)

enum SETT {CAM_SENSI,CAM_SENSI_MOVE}
enum MODE {VOID,ADD,REMOVE,LINE,BUCKET,LIGHT}

var block_view: bool = false
var edit_node
var block
var mode
var layer_select: int
var save_path_explorer: String
var env : Environment = preload("res://default_env.tres")
var undo: Array = []
var system_path: String = str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS),"/.GridEx")


var tile: Dictionary = {
	id_tile = -1,
	id_group = -1,
	icon = null,
}
var view3d: Dictionary = {
	cam = null,
	ray = null,
	pos = null,
}
var view2d: Dictionary = {
	preview2d = null,
	axis = null,
	viewport = null,
}
var snapped: Dictionary = {
	pos = true,
	rot = true
}
var settings: Array = [
	50,50,50
]


func _ready() -> void:
	var dic = Directory.new()
	if dic.dir_exists(system_path) == false:
		
		dic.open(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
		
		dic.list_dir_begin()
		
		dic.make_dir(".GridEx")


func open_project(dir: String) -> void:
	get_tree().reload_current_scene()
	yield(get_tree().create_timer(0.3),"timeout")
	
	for groups in edit_node.Tile_groups.get_children():
		groups.queue_free()
	
	yield(get_tree().create_timer(0.3),"timeout")
	
	edit_node.Layer_panel.Layers.get_child(0).queue_free()
	for layers in block.get_children():
		layers.queue_free()
	
	yield(get_tree().create_timer(0.5),"timeout")
	Save.open_project(dir)


func search_arr_dic(array: Array,pos: int, value):
	for values in array:
		if values.values()[pos] == value:
			return values
	
	return false


func makelocal(node,owner_node):
	node.filename = ""
	node.set_owner(owner_node)
	
	for child in node.get_children():
		child = makelocal(child,owner_node)
	
	return node

